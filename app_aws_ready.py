from flask import Flask, render_template, request, redirect, url_for, flash, jsonify, session
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager, UserMixin, login_user, login_required, current_user, logout_user
import joblib
from twilio.rest import Client
from datetime import datetime
from flask_mail import Mail, Message
import threading
import random
import os
import dotenv
from dotenv import load_dotenv
from google_auth_oauthlib.flow import Flow
import requests
import json
from flask_cors import CORS
from flask_session import Session
from google.oauth2.credentials import Credentials
from googleapiclient.discovery import build
import time
import logging
import csv
import pandas as pd
import folium
from geopy.distance import geodesic
from polyline import decode
from scipy.interpolate import interp1d
import numpy as np
from math import radians, cos, sin, sqrt, atan2
import getpass
from flask.cli import AppGroup

# Load environment variables
load_dotenv()

# Use relative paths for AWS deployment
CSV_FILE = os.path.join(os.path.dirname(__file__), "blood_banks.csv")

logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

# Initialize Flask app
app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}}, supports_credentials=True)

# Database Configuration for AWS deployment
database_url = os.getenv('DATABASE_URL')
if database_url and database_url.startswith('postgres://'):
    database_url = database_url.replace('postgres://', 'postgresql://', 1)

app.config['SQLALCHEMY_DATABASE_URI'] = database_url or 'postgresql://postgres:password@localhost:5432/sustainability_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', 'your-secret-key-here')
app.config['SESSION_TYPE'] = 'filesystem'

# Initialize extensions
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
login_manager = LoginManager(app)
login_manager.login_view = 'login'
Session(app)

# Google OAuth Configuration
GOOGLE_CLIENT_ID = os.getenv('GOOGLE_CLIENT_ID', '57739675915-v6b026qitqtqfpb6uipb96u72id72bub.apps.googleusercontent.com')
GOOGLE_CLIENT_SECRET = os.getenv('GOOGLE_CLIENT_SECRET', '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')
SCOPES = ['https://www.googleapis.com/auth/fitness.activity.read']
REDIRECT_URI = os.getenv('REDIRECT_URI', 'http://localhost:5000/oauth2callback')

# Initialize Flask-Mail
mail = Mail(app)

# Load credentials from a JSON file
creds_path = os.path.join(os.path.dirname(__file__), "creds.json")
try:
    with open(creds_path) as f:
        credentials = json.load(f)
    client_id = credentials['web']['client_id']
    client_secret = credentials['web']['client_secret']
    redirect_uris = credentials['web']['redirect_uris']

    flow = Flow.from_client_config(
        {
            "web": {
                "client_id": client_id,
                "client_secret": client_secret,
                "auth_uri": "https://accounts.google.com/o/oauth2/auth",
                "token_uri": "https://oauth2.googleapis.com/token",
                "redirect_uris": os.getenv('REDIRECT_URI', 'http://localhost:5000/oauth2callback')
            }
        },
        scopes=SCOPES,
        redirect_uri=redirect_uris[0]
    )
except FileNotFoundError:
    logging.warning("creds.json not found. Google OAuth features will be disabled.")
    flow = None

# Twilio Configuration
TWILIO_ACCOUNT_SID = os.getenv('TWILIO_ACCOUNT_SID', 'AC1e23a4a5289b9eef5e23eb51f03b8792')
TWILIO_AUTH_TOKEN = os.getenv('TWILIO_AUTH_TOKEN', 'eb99e476c932a8e1cefd3b33e8c33207')
TWILIO_PHONE_NUMBER = os.getenv('TWILIO_PHONE_NUMBER', '+13306425776')

client = Client(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)

# API Keys
TOMTOM_API_KEY = os.getenv('TOMTOM_API_KEY', "UsMEnScMCrNvkFm5AQQV44NyV03n0zsG")
WEATHERBIT_API_KEY = os.getenv('WEATHERBIT_API_KEY', "8d3143f5bfb641cca365e5dc3b891902")

# Database Models
class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100), unique=True, nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.Text, nullable=False)
    phone_number = db.Column(db.String(15))
    points = db.Column(db.Integer, default=0)
    badge = db.Column(db.String(50), default="Beginner")
    is_admin = db.Column(db.Boolean, default=False)

class Orphanage(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    address = db.Column(db.String(200), nullable=False)
    contact_number = db.Column(db.String(15), nullable=False)

class FoodDonation(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    orphanage_id = db.Column(db.Integer, db.ForeignKey('orphanage.id'), nullable=False)
    food_type = db.Column(db.String(50), nullable=False)
    quantity = db.Column(db.Float, nullable=False)
    pickup_time = db.Column(db.DateTime, nullable=False)
    pickup_place = db.Column(db.String(200), nullable=False)
    status = db.Column(db.String(20), default='Scheduled')

class ParkingLot(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    total_bike_slots = db.Column(db.Integer, default=500)
    total_car_slots = db.Column(db.Integer, default=200)
    slots = db.relationship('ParkingSlot', backref='parking_lot', lazy=True)

class ParkingSlot(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    lot_id = db.Column(db.Integer, db.ForeignKey('parking_lot.id'), nullable=False)
    slot_type = db.Column(db.String(10), nullable=False)  # 'Bike' or 'Car'
    status = db.Column(db.String(10), default='Vacant')  # 'Occupied' or 'Vacant'
    current_user = db.Column(db.String(100), nullable=True)
    allotted_time = db.Column(db.Time, nullable=True)
    expiry_time = db.Column(db.Time, nullable=True)

class Booking(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    slot_id = db.Column(db.Integer, db.ForeignKey('parking_slot.id'), nullable=False)
    booking_date = db.Column(db.Date, nullable=False)
    start_time = db.Column(db.Time, nullable=False)
    end_time = db.Column(db.Time, nullable=False)
    status = db.Column(db.String(20), default='Active')
    otp = db.Column(db.Integer)

class BloodDonor(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    blood_type = db.Column(db.String(5), nullable=False)
    phone_number = db.Column(db.String(15), nullable=False)
    location = db.Column(db.String(200), nullable=False)
    is_available = db.Column(db.Boolean, default=True)

class BloodRequest(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    blood_type = db.Column(db.String(5), nullable=False)
    urgency = db.Column(db.String(20), nullable=False)
    location = db.Column(db.String(200), nullable=False)
    status = db.Column(db.String(20), default='Pending')

class ContactFormSubmission(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), nullable=False)
    subject = db.Column(db.String(200), nullable=False)
    message = db.Column(db.Text, nullable=False)
    timestamp = db.Column(db.DateTime)

# CLI Commands
cli = AppGroup('admin')

@cli.command("create_admin")
def create_admin():
    username = input("Enter Admin's name:")
    email = input("Enter admin email: ")
    password = input("Enter admin password: ")
    user = User(username=username, email=email, password=password, is_admin=True)
    db.session.add(user)
    db.session.commit()
    print(f"Admin user {email} created successfully!")

app.cli.add_command(cli)

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

# Routes
@app.route('/')
def home():
    return render_template('dashboard.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        phone_number = request.form['phone_number']

        user = User(username=username, email=email, password=password, phone_number=phone_number)
        db.session.add(user)
        db.session.commit()

        flash('Registration Successful! Please log in.', 'success')
        return redirect(url_for('login'))

    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        user = User.query.filter_by(email=email).first()

        if not user:
            flash('Error: No account found with this email.', 'danger')
        elif user.password != password:
            flash('Error: Incorrect password. Please try again.', 'danger')
        else:
            login_user(user)
            flash('Login successful!', 'success')
            return redirect(url_for('index'))

    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash('You have been logged out successfully.', 'success')
    return redirect(url_for('login'))

@app.route('/dashboard')
@login_required
def dashboard():
    return render_template('dashboard.html', username=current_user.username, points=current_user.points, badge=current_user.badge)

@app.route('/index')
@login_required
def index():
    return render_template('index.html', username=current_user.username, points=current_user.points, badge=current_user.badge)

# Add other routes as needed...

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True, host='0.0.0.0', port=int(os.environ.get('PORT', 5000))) 