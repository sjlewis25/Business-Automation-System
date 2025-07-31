#!/bin/bash
apt update -y
apt install -y python3-pip mysql-client awscli jq
pip3 install flask pymysql gunicorn

# Fetch secret from Secrets Manager
SECRET=$(aws secretsmanager get-secret-value --secret-id prod/db-credentials --region us-east-1)
DB_USER=$(echo $SECRET | jq -r '.SecretString' | jq -r '.username')
DB_PASS=$(echo $SECRET | jq -r '.SecretString' | jq -r '.password')

# Store credentials securely in a config file (not hardcoded)
mkdir -p /app
echo "DB_USER=$DB_USER" >> /app/app.env
echo "DB_PASS=$DB_PASS" >> /app/app.env
chmod 600 /app/app.env

# Create simple Flask app
cat <<EOL > /app/app.py
from flask import Flask
import pymysql
import os

app = Flask(__name__)

@app.route("/")
def home():
    return "Business Automation App with RDS is Running!"

if __name__ == "__main__":
    app.run(host="0.0.0.0")
EOL

cd /app
gunicorn -w 2 -b 0.0.0.0:80 app:app &

