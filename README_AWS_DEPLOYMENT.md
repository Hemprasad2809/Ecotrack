# AWS Deployment Guide for ECOTRACK Application

## Prerequisites

1. **AWS Account**: You need an active AWS account
2. **AWS CLI**: Install AWS Command Line Interface
3. **EB CLI**: Install Elastic Beanstalk CLI: `pip install awsebcli`
4. **Database**: Set up RDS MySQL/PostgreSQL instance
5. **Domain**: Optional - for custom domain setup

## Step 1: Database Setup

### Option A: AWS RDS MySQL
1. Go to AWS RDS Console
2. Create a new MySQL database instance
3. Note down the endpoint, username, password, and database name
4. Update your environment variables with the database URL

### Option B: AWS RDS PostgreSQL (Recommended)
1. Go to AWS RDS Console
2. Create a new PostgreSQL database instance
3. Update requirements.txt to include `psycopg2-binary`
4. Update your environment variables

## Step 2: Environment Variables Setup

Create a `.env` file in your project root with the following variables:

```bash
# Database Configuration
DATABASE_URL=postgresql://username:password@your-rds-endpoint:5432/database_name

# Flask Configuration
SECRET_KEY=your-secure-secret-key-here
FLASK_ENV=production

# Google OAuth Configuration
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret
REDIRECT_URI=https://your-domain.com/oauth2callback

# Twilio Configuration
TWILIO_ACCOUNT_SID=your-twilio-account-sid
TWILIO_AUTH_TOKEN=your-twilio-auth-token
TWILIO_PHONE_NUMBER=your-twilio-phone-number

# API Keys
GEMINI_API_KEY=your-gemini-api-key
TOMTOM_API_KEY=your-tomtom-api-key
WEATHERBIT_API_KEY=your-weatherbit-api-key
```

## Step 3: Google OAuth Setup

1. Go to Google Cloud Console
2. Update your OAuth 2.0 credentials
3. Add your production domain to authorized redirect URIs
4. Update the `REDIRECT_URI` environment variable

## Step 4: Deploy to AWS Elastic Beanstalk

### Method 1: Using EB CLI (Recommended)

```bash
# Install EB CLI if not already installed
pip install awsebcli

# Initialize EB application
eb init ecotrack-app --platform python-3.9 --region us-east-1

# Create environment
eb create ecotrack-env --instance-type t3.small --single-instance

# Set environment variables
eb setenv DATABASE_URL="your-database-url"
eb setenv SECRET_KEY="your-secret-key"
# ... set all other environment variables

# Deploy
eb deploy
```

### Method 2: Using AWS Console

1. Go to AWS Elastic Beanstalk Console
2. Create new application
3. Upload your code as a ZIP file
4. Configure environment variables
5. Deploy

## Step 5: Configure Security Groups

1. Go to EC2 Console > Security Groups
2. Create/update security group for your EB environment
3. Allow inbound traffic on port 80 (HTTP) and 443 (HTTPS)
4. Allow outbound traffic to your RDS database

## Step 6: SSL Certificate (Optional)

1. Request SSL certificate in AWS Certificate Manager
2. Configure HTTPS listener in your load balancer
3. Update your domain DNS settings

## Step 7: Monitoring and Logging

1. Set up CloudWatch alarms
2. Configure log aggregation
3. Set up health checks

## Troubleshooting

### Common Issues:

1. **Database Connection**: Ensure RDS security group allows EB environment
2. **Environment Variables**: Check EB environment configuration
3. **File Paths**: All paths are now relative to the application root
4. **Dependencies**: Ensure all packages are in requirements.txt

### Logs:
```bash
# View application logs
eb logs

# SSH into instance (if needed)
eb ssh
```

## Cost Optimization

1. Use t3.small for development
2. Consider reserved instances for production
3. Monitor usage with AWS Cost Explorer
4. Use S3 for static file storage

## Security Best Practices

1. Use environment variables for all secrets
2. Enable AWS CloudTrail
3. Use IAM roles instead of access keys
4. Regularly update dependencies
5. Enable AWS WAF for additional protection

## Backup Strategy

1. Enable automated RDS backups
2. Set up S3 bucket for file backups
3. Configure cross-region replication
4. Test restore procedures regularly 