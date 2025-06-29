import pandas as pd

orders = pd.read_csv('../original_dataset/olist_orders_dataset.csv')

orders = orders[['order_purchase_timestamp', 'order_id']]
orders.rename(columns={'order_purchase_timestamp': 'order_date'}, inplace=True)
orders['order_date'] = pd.to_datetime(orders['order_date'], format='%Y-%m-%d %H:%M:%S')

orders['year'] = orders['order_date'].dt.year
orders['month'] = orders['order_date'].dt.month
orders['day'] = orders['order_date'].dt.day
orders['hour'] = orders['order_date'].dt.hour
orders['minute'] = orders['order_date'].dt.minute
orders['second'] = orders['order_date'].dt.second
orders['day_of_week'] = orders['order_date'].dt.dayofweek
orders['quarter'] = orders['order_date'].dt.quarter

orders = orders.drop(columns=['order_id'])

orders.rename(columns={'order_date': 'date_id'}, inplace=True)

orders.to_csv('../processed_data/dim_date.csv', index=False)
