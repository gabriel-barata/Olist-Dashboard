CREATE SCHEMA IF NOT EXISTS stg;

CREATE TABLE IF NOT EXISTS stg.orders (
  order_id VARCHAR(36) PRIMARY KEY,
  customer_id VARCHAR(36),
  order_status VARCHAR(50),
  order_purchase_timestamp TIMESTAMP,
  order_approved_at TIMESTAMP,
  order_delivered_carrier_date TIMESTAMP,
  order_delivered_customer_date TIMESTAMP,
  order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE IF NOT EXISTS stg.order_items (
  order_id VARCHAR(36),
  order_item_id INT,
  product_id VARCHAR(36),
  seller_id VARCHAR(36),
  shipping_limit_date TIMESTAMP,
  price FLOAT,
  freight_value FLOAT
);

CREATE TABLE IF NOT EXISTS stg.order_payments (
  order_id VARCHAR(36),
  payment_sequential INT,
  payment_type VARCHAR(50),
  payment_installments INT,
  payment_value FLOAT
);

CREATE TABLE IF NOT EXISTS stg.products (
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

CREATE TABLE IF NOT EXISTS stg.sellers (
  seller_id VARCHAR(36) PRIMARY KEY,
  seller_zip_code_prefix VARCHAR(10),
  seller_city TEXT,
  seller_state VARCHAR(2)
);

CREATE TABLE IF NOT EXISTS stg.order_reviews (
  review_id VARCHAR(36),
  order_id VARCHAR(36),
  review_score INT,
  review_comment_title TEXT,
  review_comment_message TEXT,
  review_creation_date TIMESTAMP,
  review_answer_timestamp TIMESTAMP,
  PRIMARY KEY (review_id, order_id)
);

CREATE TABLE IF NOT EXISTS stg.customers (
  customer_id VARCHAR(36) PRIMARY KEY,
  customer_unique_id VARCHAR(36),
  customer_zip_code_prefix VARCHAR(10),
  customer_city TEXT,
  customer_state VARCHAR(2)
);

COMMIT;