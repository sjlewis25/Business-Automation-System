#!/bin/bash
yum update -y
yum install -y python3 git

cd /home/ec2-user
git clone https://github.com/sjlewis25/business-automation-system.git
cd business-automation-system/app

pip3 install -r requirements.txt

# Export DB credentials
export DB_HOST="${db_host}"
export DB_USER="${db_user}"
export DB_PASS="${db_password}"

# Start the Flask app
FLASK_APP=app.py nohup flask run --host=0.0.0.0 --port=5000 &
