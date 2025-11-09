# update_orphanage_numbers.py
from app import app, db, Orphanage

def update_numbers():
    with app.app_context():
        orphanages = Orphanage.query.all()
        for orphanage in orphanages:
            orphanage.contact_number = "9841602444"
        db.session.commit()
        print("All orphanage contact numbers updated.")

if __name__ == "__main__":
    update_numbers()