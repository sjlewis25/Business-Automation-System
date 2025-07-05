#!/bin/bash
sudo apt update -y
sudo apt install python3-pip -y
pip3 install flask gunicorn pymysql

# Set environment variables
echo "export DB_HOST='$(terraform output -raw rds_endpoint | cut -d: -f1)'" >> /home/ubuntu/.bashrc
echo "export DB_USER='admin'" >> /home/ubuntu/.bashrc
echo "export DB_PASSWORD='YourStrongPassword123!'" >> /home/ubuntu/.bashrc

# Create app directory
mkdir -p /home/ubuntu/app
cd /home/ubuntu/app

# Create Flask app
cat <<EOF > app.py
from flask import Flask, request, jsonify
import pymysql
import os

app = Flask(__name__)

conn = pymysql.connect(
    host=os.environ.get("DB_HOST"),
    user=os.environ.get("DB_USER"),
    password=os.environ.get("DB_PASSWORD"),
    database="smartops",
    autocommit=True
)
cursor = conn.cursor()
cursor.execute("CREATE DATABASE IF NOT EXISTS smartops")
cursor.execute("USE smartops")
cursor.execute("CREATE TABLE IF NOT EXISTS tasks (id INT AUTO_INCREMENT PRIMARY KEY, title VARCHAR(255))")

@app.route("/")
def index():
    return "Business Automation App with RDS is Running!"

@app.route("/tasks", methods=["POST"])
def create_task():
    data = request.get_json()
    title = data.get("title", "")
    cursor.execute("INSERT INTO tasks (title) VALUES (%s)", (title,))
    return jsonify({"message": "Task created"}), 201

@app.route("/tasks", methods=["GET"])
def get_tasks():
    cursor.execute("SELECT * FROM tasks")
    tasks = [{"id": row[0], "title": row[1]} for row in cursor.fetchall()]
    return jsonify(tasks)
EOF

# Run Flask app with gunicorn on port 80
cd /home/ubuntu/app
gunicorn --bind 0.0.0.0:80 app:app --daemon

