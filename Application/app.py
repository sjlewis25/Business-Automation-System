from flask import Flask, request, jsonify
import pymysql
import boto3
import json

app = Flask(__name__)

# Get DB credentials securely from AWS Secrets Manager
def get_db_config():
    client = boto3.client("secretsmanager", region_name="us-east-1")
    secret = client.get_secret_value(SecretId="rds_app_credentials")
    return json.loads(secret["SecretString"])

secret = get_db_config()
DB_HOST = secret["DB_HOST"]
DB_USER = secret["DB_USER"]
DB_PASS = secret["DB_PASS"]
DB_NAME = secret["DB_NAME"]

# DB connection
def get_connection():
    return pymysql.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASS,
        database=DB_NAME,
        cursorclass=pymysql.cursors.DictCursor
    )

@app.route("/")
def index():
    return "Business Automation System is running."

@app.route("/submit_order", methods=["POST"])
def submit_order():
    data = request.get_json()
    customer = data.get("customer")
    item = data.get("item")
    quantity = data.get("quantity")

    if not all([customer, item, quantity]):
        return jsonify({"error": "Missing required fields"}), 400

    try:
        conn = get_connection()
        with conn.cursor() as cursor:
            sql = "INSERT INTO orders (customer, item, quantity) VALUES (%s, %s, %s)"
            cursor.execute(sql, (customer, item, quantity))
        conn.commit()
        return jsonify({"message": "Order received", "data": data}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        conn.close()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)


