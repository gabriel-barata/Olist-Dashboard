import json

_config = {
    'meta': {
        'author': 'gabriel-barata',
        'version': '1.0',
        'tables_to_fetch': [
            'customers',
            'order_items',
            'order_payments',
            'order_reviews',
            'orders',
            'products',
            'sellers'
        ],
        'logs_folder': './logs/'
    },
    'credentials': {
        'mysql': {
            'username': 'root',
            'password': 'root',
            'port': 3306,
            'database': 'olist'
        },
        'postgres': {
            'username': 'postgres',
            'password': 'daniella',
            'port': 5433,
            'database': 'postgres',
            'host': 'localhost'
        }
    }
}

def get_config(load_from_file = False):
    if load_from_file:
        with open('config.json', 'r') as f:
            return json.load(f)
    return _config

def generate_config():
    with open('config.json', 'w') as f:
        return json.dump(_config, f, indent = 4)

if __name__ == '__main__':
    generate_config()