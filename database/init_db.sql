USE olist;

CREATE TABLE IF NOT EXISTS orders (
  order_id VARCHAR(36) PRIMARY KEY,
  customer_id VARCHAR(36),
  order_status VARCHAR(50),
  order_purchase_timestamp TIMESTAMP,
  order_approved_at TIMESTAMP,
  order_delivered_carrier_date TIMESTAMP,
  order_delivered_customer_date TIMESTAMP,
  order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items (
  order_id VARCHAR(36),
  order_item_id INT,
  product_id VARCHAR(36),
  seller_id VARCHAR(36),
  shipping_limit_date TIMESTAMP,
  price FLOAT,
  freight_value FLOAT
);

CREATE TABLE IF NOT EXISTS order_payments (
  order_id VARCHAR(36),
  payment_sequential INT,
  payment_type VARCHAR(50),
  payment_installments INT,
  payment_value FLOAT
);

CREATE TABLE IF NOT EXISTS products (
  product_id VARCHAR(36) PRIMARY KEY,
  product_category_name VARCHAR(255),
  product_name_length INT,
  product_description_length INT,
  product_photos_qty INT,
  product_weight_g INT,
  product_length_cm INT,
  product_height_cm INT,
  product_width_cm INT
);

CREATE TABLE IF NOT EXISTS sellers (
  seller_id VARCHAR(36) PRIMARY KEY,
  seller_zip_code_prefix VARCHAR(10),
  seller_city TEXT,
  seller_state VARCHAR(2)
);

CREATE TABLE IF NOT EXISTS order_reviews (
  review_id VARCHAR(36),
  order_id VARCHAR(36),
  review_score INT,
  review_comment_title TEXT,
  review_comment_message TEXT,
  review_creation_date TIMESTAMP,
  review_answer_timestamp TIMESTAMP,
  PRIMARY KEY (review_id, order_id)
);

CREATE TABLE IF NOT EXISTS customers (
  customer_id VARCHAR(36) PRIMARY KEY,
  customer_unique_id VARCHAR(36),
  customer_zip_code_prefix VARCHAR(10),
  customer_city TEXT,
  customer_state VARCHAR(2)
);

ALTER TABLE order_payments ADD FOREIGN KEY (order_id) REFERENCES orders (order_id);
ALTER TABLE order_items ADD FOREIGN KEY (order_id) REFERENCES orders (order_id);
ALTER TABLE order_reviews ADD FOREIGN KEY (order_id) REFERENCES orders (order_id);
ALTER TABLE orders ADD FOREIGN KEY (customer_id) REFERENCES customers (customer_id);
ALTER TABLE order_items ADD FOREIGN KEY (product_id) REFERENCES products (product_id);
ALTER TABLE order_items ADD FOREIGN KEY (seller_id) REFERENCES sellers (seller_id);

SET FOREIGN_KEY_CHECKS = 0;

LOAD DATA INFILE '/var/lib/mysql-files/olist_csv/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(product_id, @col1, @col2, @col3, @col4, @col5, @col6, @col7, @col8)
SET
	product_category_name = NULLIF(@col1, ''),
	product_name_length = NULLIF(@col2, ''),
	product_description_length = NULLIF(@col3, ''),
	product_photos_qty = NULLIF(@col4, ''),
	product_weight_g = NULLIF(@col5, ''),
	product_length_cm = NULLIF(@col6, ''),
	product_height_cm = NULLIF(@col7, ''),
	product_width_cm = NULLIF(@col8, '') + 0;

LOAD DATA INFILE '/var/lib/mysql-files/olist_csv/olist_order_payments_dataset.csv'
INTO TABLE order_payments
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql-files/olist_csv/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(order_id, customer_id, order_status, @purchase_ts, @approved_ts, @carrier_date, @customer_date, @estimated_date)
SET
	order_purchase_timestamp = NULLIF(@purchase_ts, ''),
	order_approved_at = NULLIF(@approved_ts, ''),
	order_delivered_carrier_date = NULLIF(@carrier_date, ''),
	order_delivered_customer_date = NULLIF(@customer_date, ''),
	order_estimated_delivery_date = NULLIF(@estimated_date, '');

LOAD DATA INFILE '/var/lib/mysql-files/olist_csv/olist_customerS_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql-files/olist_csv/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql-files/olist_csv/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 LINES;

SET FOREIGN_KEY_CHECKS = 1;

CREATE USER 'airflow'@'%' IDENTIFIED BY 'airflow';
GRANT SELECT ON olist.* TO 'airflow'@'%';
FLUSH PRIVILEGES;