from utils.connectors import connectToMySQL, connectToPostgres
from utils.transfer import data_transfer
from config.config import get_config
from datetime import date
import os

env = get_config()
mysql_credentials = dict(
    username=env.get('credentials').get('mysql').get('username'),
    password=env.get('credentials').get('mysql').get('password'),
    port=env.get('credentials').get('mysql').get('port'),
    database=env.get('credentials').get('mysql').get('database')
)
postgres_credentials = dict(
    user=env.get('credentials').get('postgres').get('username'),
    password=env.get('credentials').get('postgres').get('password'),
    port=env.get('credentials').get('postgres').get('port'),
    database=env.get('credentials').get('postgres').get('database'),
    host=env.get('credentials').get('postgres').get('host')
)
log_file = env.get('meta').get('logs_folder') + str(date.today()) + '.log'

if __name__ == '__main__':

    if not os.path.exists('./logs'):
        os.mkdir('./logs')

    mysql_cur = connectToMySQL(log_file=log_file,
                   **mysql_credentials
                   )
    postgres_cur = connectToPostgres(log_file=log_file,
                                     **postgres_credentials
                                     )
    data_transfer(log_file=log_file,
                  mysql_cur=mysql_cur,
                  postgres_cur=postgres_cur,
                  first_run=True,
                  tables=env.get('meta').get('tables_to_fetch'))