from flask import Flask, request, jsonify
import pymysql
import os

app = Flask(__name__)

# Database configuration
DB_HOST = os.getenv("DB_HOST", "your-db-endpoint.amazonaws.com")
DB_USER = os.getenv("DB_USER", "admin")
DB_PASS = os.getenv("DB_PASS", "StrongPassword123!")
DB_NAME = os.getenv("DB_NAME", "smartops")

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

