#!/bin/bash

set -e

# Install system dependencies
yum update -y
yum install -y python3 git mysql jq aws-cli

# Upgrade pip
python3 -m pip install --upgrade pip

# Clone your GitHub repo
cd /home/ec2-user
git clone https://github.com/sjlewis25/Business-Automation-System.git

cd Business-Automation-System/Application

# Install Python dependencies
pip3 install -r requirements.txt

# Fetch secrets from AWS Secrets Manager
SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id flask-db-secret --query SecretString --output text)

# Export environment variables
export DB_HOST=$(echo $SECRET_JSON | jq -r .host)
export DB_USER=$(echo $SECRET_JSON | jq -r .username)
export DB_PASS=$(echo $SECRET_JSON | jq -r .password)
export DB_NAME=$(echo $SECRET_JSON | jq -r .dbname)

# Start Flask app
nohup python3 app.py > /var/log/flask_app.log 2>&1 &
