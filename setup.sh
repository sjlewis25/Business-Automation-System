#!/bin/bash
# Install Python and dependencies
apt update -y
apt install -y python3-pip mysql-client
pip3 install flask gunicorn pymysql

# Export DB connection details (update if needed)
export DB_HOST="your-db-endpoint.amazonaws.com"
export DB_USER="admin"
export DB_PASS="StrongPassword123!"
export DB_NAME="smartops"

# Create DB schema if it doesn't exist
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME -e "
CREATE TABLE IF NOT EXISTS tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'todo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);"

# Create app directory and launch Flask
mkdir -p /app
echo "$FLASK_APP_CODE" > /app/app.py
cd /app
gunicorn -w 2 -b 0.0.0.0:80 app:app &
