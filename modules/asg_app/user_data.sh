#!/bin/bash
yum update -y
yum install -y python3 git

# Switch to ec2-user home
cd /home/ec2-user

# Clone the app repo
git clone https://github.com/sjlewis25/business-automation-system.git
cd business-automation-system/app

# Install Python dependencies
pip3 install -r requirements.txt

# Export DB environment variables system-wide
echo "export DB_HOST='${db_host}'" >> /etc/profile
echo "export DB_USER='${db_user}'" >> /etc/profile
echo "export DB_PASS='${db_password}'" >> /etc/profile

# Start the Flask app
FLASK_APP=app.py nohup flask run --host=0.0.0.0 --port=5000 > /var/log/flask.log 2>&1 &
