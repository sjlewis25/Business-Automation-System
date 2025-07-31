#!/bin/bash
apt update -y
apt install -y python3-pip mysql-client
pip3 install flask pymysql gunicorn
mkdir -p /app
cat <<EOL > /app/app.py
from flask import Flask
import pymysql
app = Flask(__name__)

@app.route("/")
def home():
    return "Business Automation App with RDS is Running!"

if __name__ == "__main__":
    app.run(host="0.0.0.0")
EOL

cd /app
gunicorn -w 2 -b 0.0.0.0:80 app:app &
