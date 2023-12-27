from flask import Flask, jsonify
import mysql.connector

app = Flask(__name__)

mysql_config = {
    'user': 'farius',
    'password': 'Project5!',
    'host': 'localhost',
    'database': 'mysql'
}

@app.route('/toronto')
def get_toronto_players():
    try:
        connection = mysql.connector.connect(**mysql_config)
        cursor = connection.cursor()
        query = "SELECT PlayerName FROM nhl WHERE Team = 'TOR'"
        cursor.execute(query)
        result = cursor.fetchall()
        players = [row[0] for row in result]
        return jsonify(players)
    except Exception as e:
        return jsonify({'error': str(e)})
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

@app.route('/points')
def get_top_10_players():
    try:
        connection = mysql.connector.connect(**mysql_config)
        cursor = connection.cursor()
        query = "SELECT PlayerName, Pts FROM nhl ORDER BY Pts LIMIT 10"
        cursor.execute(query)
        result = cursor.fetchall()
        players = [{'PlayerName': row[0], 'Pts': row[1]} for row in result]
        return jsonify(players)
    except Exception as e:
        return jsonify({'error': str(e)})
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

@app.route('/players')
def get_all_players():
    try:
        connection = mysql.connector.connect(**mysql_config)
        cursor = connection.cursor()
        query = "SELECT PlayerName FROM nhl LIMIT 10"
        cursor.execute(query)
        result = cursor.fetchall()
        players = [row[0] for row in result]
        return jsonify(players)
    except Exception as e:
        return jsonify({'error': str(e)})
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

if __name__ == '__main__':
    app.run()
