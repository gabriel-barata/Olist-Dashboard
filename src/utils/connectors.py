import mysql.connector
import psycopg2
import logging

def connectToMySQL(log_file: str,
                   **cred):

    logging.basicConfig(filename=log_file,
                        level=logging.INFO,
                        format='%(asctime)s - %(levelname)s - %(message)s')

    try:
        conn = mysql.connector.connect(**cred)
        cur = conn.cursor()

        logging.info('MYSQL - CONNECTION SUCCESSFUL')

        return cur

    except mysql.connector.Error as e:

        logging.error(f'MYSQL - CONNECTION ERROR: {e}')

def connectToPostgres(log_file: str,
                   **cred):

    logging.basicConfig(filename=log_file,
                        level=logging.INFO,
                        format='%(asctime)s - %(levelname)s - %(message)s')
    try:
        conn = psycopg2.connect(**cred)
        cur = conn.cursor()
        logging.info('POSTGRES - CONNECTION SUCCESSFUL')

        return cur
    except psycopg2.Error as e:

        logging.error(f'POSTGRES - CONNECTION ERROR: {e}')