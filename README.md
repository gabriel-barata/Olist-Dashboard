# Data Warehouse Implementation
## Intro
This project is made in order test the [astro SDK](https://docs.astronomer.io/learn/astro-python-sdk-etl) kit for Apache Airflow doing a pratical Data Warehouse implementation with it. For this we’ll use the olist dataset, which is a brazilian public ecommerce dataset of orders made at [Olist Store](https://olist.com/pt-br/).  
This project have two deliverables: a **Data Warehouse** and a **web based data viz application**.  
## About the Data
The original data follows a common **OLTP** approach, being very similar to the data that we can find inside ordering applications backend databases, but slightly denormalized.  For this reason we are going to insert the original data inside a MySQL database, simulating the backend of a real application in production.
<img src="https://iili.io/HyGAwuf.png" alt="app-db-formation" width="600" height= "250"/>
## Solution's Architecture
### Dimensional Modeling
insert the data first to check it
# Next Steps
1. Logical Model to understand the business -> kind of the database arch itself
2. Insert the data into MySQL
3. Dimensional Model to know what we will insert in the database
    - Define DIMs and FACTs  

you'll need the [astro CLI](https://docs.astronomer.io/astro/cli/overview)