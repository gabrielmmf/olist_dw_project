-- SCRIPT: create_and_insert_dw.sql

-- DATABASE CREATION
CREATE DATABASE IF NOT EXISTS olist_dw;

USE olist_dw;

-- ================== DIMENSIONS ==================

-- dim_date
CREATE TABLE IF NOT EXISTS dim_date (
    id Int32,
    full_date Date,
    year Int32,
    month Int32,
    day Int32,
    day_of_week String
) ENGINE = MergeTree() ORDER BY id;

-- dim_customer
CREATE TABLE IF NOT EXISTS dim_customer (
    id Int32,
    customer_id String,
    unique_id String,
    city String,
    state String
) ENGINE = MergeTree() ORDER BY id;

-- dim_product
CREATE TABLE IF NOT EXISTS dim_product (
    id Int32,
    product_id String,
    category String,
    category_english String,
    weight_g Float64,
    length_cm Float64,
    height_cm Float64,
    width_cm Float64
) ENGINE = MergeTree() ORDER BY id;

-- dim_seller
CREATE TABLE IF NOT EXISTS dim_seller (
    id Int32,
    seller_id String,
    city String,
    state String
) ENGINE = MergeTree() ORDER BY id;

-- dim_location
CREATE TABLE IF NOT EXISTS dim_location (
    id Int32,
    zip_prefix Int32,
    city String,
    state String,
    lat Float64,
    lng Float64
) ENGINE = MergeTree() ORDER BY id;

-- dim_payment
CREATE TABLE IF NOT EXISTS dim_payment (
    id Int32,
    order_id String,
    payment_sequential Int32,
    type String
) ENGINE = MergeTree() ORDER BY id;

-- dim_review
CREATE TABLE IF NOT EXISTS dim_review (
    id Int32,
    review_id String,
    comment_title String,
    comment_message String,
    creation_date Date,
    answer_timestamp DateTime
) ENGINE = MergeTree() ORDER BY id;

-- ================== FACTS ==================

-- fct_sales
CREATE TABLE IF NOT EXISTS fct_sales (
    id Int32,
    order_id String,
    order_item_id Int32,
    date_id Int32,
    customer_id Int32,
    product_id Int32,
    seller_id Int32,
    location_id Int32,
    payment_id Int32,
    price Float64,
    freight Float64,
    total Float64,
    delivery_days Int32
) ENGINE = MergeTree() ORDER BY id;

-- fct_reviews
CREATE TABLE IF NOT EXISTS fct_reviews (
    id Int32,
    order_id String,
    date_id Int32,
    customer_id Int32,
    product_id Int32,
    seller_id Int32,
    review_id Int32,
    review_score Int32,
    response_time Int32,
    has_comment UInt8
) ENGINE = MergeTree() ORDER BY id;

-- fct_payments
CREATE TABLE IF NOT EXISTS fct_payments (
    id Int32,
    order_id String,
    date_id Int32,
    customer_id Int32,
    payment_id Int32,
    payment_type_id Int32,
    payment_value Float64,
    installments Int32
) ENGINE = MergeTree() ORDER BY id;

-- ================== OBSERVAÇÃO ==================
-- O ClickHouse não suporta INSERT INTO ... SELECT FROM file() com verificação direta de ID duplicado.
-- Para evitar duplicação, faça a carga via script externo com verificação de ID ou usando staging tables.
-- Você pode usar clickhouse-client como abaixo:

-- Exemplo (via terminal):
-- clickhouse-client --query="INSERT INTO olist_dw.dim_customer FORMAT CSVWithNames" < transformed/dim_customer.csv
-- clickhouse-client --query="INSERT INTO olist_dw.fct_sales FORMAT CSVWithNames" < transformed/fct_sales.csv