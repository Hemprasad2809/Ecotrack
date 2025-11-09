#!/bin/bash

# AWS Deployment Script for ECOTRACK Application

echo "Starting AWS deployment..."

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it first."
    exit 1
fi

# Check if EB CLI is installed
if ! command -v eb &> /dev/null; then
    echo "EB CLI is not installed. Please install it first: pip install awsebcli"
    exit 1
fi

# Initialize EB application if not already done
if [ ! -f ".elasticbeanstalk/config.yml" ]; then
    echo "Initializing Elastic Beanstalk application..."
    eb init ecotrack-app --platform python-3.9 --region us-east-1
fi

# Create environment if it doesn't exist
if ! eb status; then
    echo "Creating Elastic Beanstalk environment..."
    eb create ecotrack-env --instance-type t3.small --single-instance
else
    echo "Deploying to existing environment..."
    eb deploy
fi

echo "Deployment completed!" 