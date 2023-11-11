from flask import Flask, jsonify, render_template, request
import psycopg2
from VULNAPI import config

app = Flask(__name__)

def connect():
    """ Connect to the PostgreSQL database server """
    conn = None
    try:
        # read connection parameters
        params = config.get_db_config()

        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)

        return conn
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

def close_connection(conn):
    """ Close the PostgreSQL database connection """
    if conn is not None:
        conn.close()
        print('Database connection closed.')

@app.route('/')
def begin():
    return render_template('welcome.html')

@app.route('/addfiles', methods=['POST'])
def add_files():
    conn = connect()
    try:
        # Your logic to add a new file to the table
        data = request.get_json()
        print('Received data:', data)  # Add this line to print received data for debugging

        file_taken = data.get('file', '')
        file_path = data.get('file_path', '')  # Added file path field
        is_infected = data.get('infected', False)
        is_clean = data.get('clean', False)
        is_quarantined = data.get('quarantine', False)

        cur = conn.cursor()
        cur.execute(
            "INSERT INTO files (file, file_path, infected, clean, quarantine) VALUES (%s, %s, %s, %s, %s)",
            (file_taken, file_path, is_infected, is_clean, is_quarantined)
        )
        conn.commit()
        cur.close()

        return jsonify({'message': 'file added successfully'})
    except Exception as e:
        return jsonify({'error': str(e)})
    finally:
        close_connection(conn)

@app.route('/getfiles')
def get_files():
    conn = connect()
    try:
        cur = conn.cursor()
        cur.execute("SELECT * FROM files")
        files = [{'id': row[0], 'file': row[1], 'file_path': row[2], 'infected': row[3], 'clean': row[4], 'quarantine': row[5]} for row in cur.fetchall()]
        return jsonify(files)
    except Exception as e:
        return jsonify({'error': str(e)})
    finally:
        close_connection(conn)

if __name__ == '__main__':
    print("Welcome to VULN")
    app.run(debug=True)
