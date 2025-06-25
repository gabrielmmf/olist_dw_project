USE olist_dw;

SELECT 'dim_customer' AS
table, count(*) AS rows
FROM dim_customer
UNION ALL
SELECT 'dim_date', count(*)
FROM dim_date
UNION ALL
SELECT 'dim_product', count(*)
FROM dim_product
UNION ALL
SELECT 'dim_seller', count(*)
FROM dim_seller
UNION ALL
SELECT 'dim_location', count(*)
FROM dim_location
UNION ALL
SELECT 'dim_payment', count(*)
FROM dim_payment
UNION ALL
SELECT 'dim_review', count(*)
FROM dim_review
UNION ALL
SELECT 'fct_sales', count(*)
FROM fct_sales
UNION ALL
SELECT 'fct_reviews', count(*)
FROM fct_reviews
UNION ALL
SELECT 'fct_payments', count(*)
FROM fct_payments;