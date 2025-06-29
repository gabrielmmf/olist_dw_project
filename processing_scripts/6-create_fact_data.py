import pandas as pd

dim_customer_df = pd.read_csv("../processed_data/dim_customer.csv")
dim_date_df = pd.read_csv('../processed_data/dim_date.csv')
dim_payment_df = pd.read_csv('../processed_data/dim_payment.csv')
dim_product_df = pd.read_csv('../processed_data/dim_product.csv')
dim_seller_df = pd.read_csv('../processed_data/dim_seller.csv')

# ponte
items_df = pd.read_csv('../original_dataset/olist_order_items_dataset.csv')
orders_df = pd.read_csv('../original_dataset/olist_orders_dataset.csv')

# merges
fct_sales = pd.merge(items_df, orders_df, on='order_id', how='left')
fct_sales = pd.merge(fct_sales, dim_customer_df, on='customer_id', how='left')
fct_sales = pd.merge(fct_sales, dim_payment_df, on='order_id', how='left')


# removendo colunas desnecessárias
fct_sales_final = fct_sales.drop(columns=[
    'shipping_limit_date',
    'order_status',
    'order_approved_at',
    'order_delivered_carrier_date',
    'order_delivered_customer_date',
    'order_estimated_delivery_date',
    'customer_unique_id',
    'city',
    'state',
    'lat',
    'lng',
    'n_payment_methods',
    'payment_method',
    'n_installments',
    'payment_value'
])
fct_sales_final["total"] = fct_sales_final["price"] * fct_sales_final["freight_value"]
fct_sales_final.rename(columns={'order_purchase_timestamp': 'date_id'}, inplace=True)

# criando id único para cada venda
fct_sales_final['sale_id'] = fct_sales_final.index + 1

fct_sales_final.to_csv('../processed_data/fct_sales.csv', index=False)
