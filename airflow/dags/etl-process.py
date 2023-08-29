from datetime import datetime, timedelta

from airflow.operators.dummy import DummyOperator
from airflow.models import DAG

from astro import sql as aql

default_args = {
    'owner': 'gabriel',
    'retries': 5,
    'retry_delay': timedelta(minutes=2)
}

with DAG(
    dag_id = 'olist-data-pipeline',
    schedule = '@once',
    start_date = datetime(2023, 1, 1),
    default_args = default_args,
    tags = ['Data Engineering', 'Astro SDK']
) as dag:

    init_pipeline = DummyOperator(task_id = 'init-pipeline')

    aql.export_to_file(
        task_id = 'save_'
    )