#!/bin/bash

# Update and install packages
yum update -y
yum install -y python3 git

# Install pip packages
pip3 install flask gunicorn pymysql boto3

# Create app directory
mkdir -p /srv/app
cat <<EOF > /srv/app/app.py
from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def index():
    return "App is running!"

@app.route("/health")
def health():
    return "OK", 200

if __name__ == "__main__":
    app.run()
EOF

# Create systemd unit for gunicorn
cat <<EOF > /etc/systemd/system/flask.service
[Unit]
Description=Flask Gunicorn App
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/srv/app
ExecStart=/usr/local/bin/gunicorn -w 2 -b 0.0.0.0:8000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Start and enable the service
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable flask
systemctl start flask
