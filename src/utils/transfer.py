from mysql.connector import connect
import psycopg2
import pandas as pd
import logging

def data_transfer(log_file: str,
                  mysql_cur: connect,
                  postgres_cur: psycopg2.connect,
                  tables: list,
                  first_run = False,
                  ):

    logging.basicConfig(filename=log_file,
                        level=logging.INFO,
                        format='%(asctime)s - %(levelname)s - %(message)s')

    if first_run:
        try:
            logging.info('POSTGRES - TRYING TO RUN INIT SCRIPT')
            with open('./utils/SQL/init_postgres.sql', 'r') as f:
                init_postgres = f.read()

            postgres_cur.execute(
                init_postgres
            )

            logging.info('POSTGRES - SUCCESSFULLY CREATED STAGING SCHEMA AND TABLES')

        except psycopg2.Error as e:
            logging.error(f'POSTGRES - ERROR WHILE RUNNING POSTGRES INIT SCRIPT {e}')

    for table in tables:
        #TODO implementar a lógica CDC de captura dos dados
        pass