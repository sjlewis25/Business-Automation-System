#!/bin/bash
set -e  

echo "[INFO] Updating system and installing dependencies..."
apt update -y
apt install -y python3-pip mysql-client awscli jq amazon-cloudwatch-agent

echo "[INFO] Installing Python packages..."
pip3 install flask pymysql gunicorn

echo "[INFO] Fetching credentials from Secrets Manager..."
SECRET=$(aws secretsmanager get-secret-value --secret-id prod/db-credentials --region us-east-1)
DB_USER=$(echo $SECRET | jq -r '.SecretString' | jq -r '.username')
DB_PASS=$(echo $SECRET | jq -r '.SecretString' | jq -r '.password')

echo "[INFO] Storing credentials..."
mkdir -p /app
cat <<EOF > /app/app.env
DB_USER=$DB_USER
DB_PASS=$DB_PASS
EOF
chmod 600 /app/app.env

echo "[INFO] Creating Flask app..."
cat <<EOF > /app/app.py
from flask import Flask
import pymysql
import os

app = Flask(__name__)

@app.route("/")
def home():
    return "Business Automation App with RDS is Running!"

if __name__ == "__main__":
    app.run(host="0.0.0.0")
EOF

echo "[INFO] Starting Flask app with Gunicorn..."
cd /app
gunicorn -w 2 -b 0.0.0.0:80 app:app --log-file /app/gunicorn.log &

echo "[INFO] Configuring CloudWatch Agent..."
cat <<EOF > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/messages",
            "log_group_name": "business-automation-logs",
            "log_stream_name": "{instance_id}-messages"
          },
          {
            "file_path": "/app/gunicorn.log",
            "log_group_name": "business-automation-logs",
            "log_stream_name": "{instance_id}-gunicorn"
          }
        ]
      }
    }
  }
}
EOF

echo "[INFO] Starting CloudWatch Agent..."
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  -s

echo "[SUCCESS] Deployment complete."
