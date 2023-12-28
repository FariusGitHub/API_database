from flask import Flask, jsonify
import mysql.connector

app = Flask(__name__)

# MySQL connection configuration
db_config = {
    'user': 'farius',
    'password': 'Project5',
    'host': 'localhost',
    'database': 'mysql'
}

# Endpoint to query players from the 'nhl' table where Team is 'TOR'
@app.route('/toronto')
def get_toronto_players():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        query = "SELECT PlayerName FROM nhl WHERE Team = 'TOR'"
        cursor.execute(query)
        players = [row[0] for row in cursor.fetchall()]
        return jsonify(players)
    except mysql.connector.Error as error:
        return jsonify({'error': str(error)})
    finally:
        cursor.close()
        conn.close()

# Endpoint to query top 10 players from the 'nhl' table ordered by Pts
@app.route('/points')
def get_top_players():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        query = "SELECT PlayerName, Pts FROM nhl ORDER BY Pts LIMIT 10"
        cursor.execute(query)
        players = [{'PlayerName': row[0], 'Pts': row[1]} for row in cursor.fetchall()]
        return jsonify(players)
    except mysql.connector.Error as error:
        return jsonify({'error': str(error)})
    finally:
        cursor.close()
        conn.close()

# Endpoint to query first 10 players from the 'nhl' table
@app.route('/players')
def get_players():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        query = "SELECT PlayerName FROM nhl LIMIT 10"
        cursor.execute(query)
        players = [row[0] for row in cursor.fetchall()]
        return jsonify(players)
    except mysql.connector.Error as error:
        return jsonify({'error': str(error)})
    finally:
        cursor.close()
        conn.close()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
