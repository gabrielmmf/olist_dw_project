import pandas as pd

customer_data = pd.read_csv('../original_dataset/olist_customers_dataset.csv')
customer_data.rename(columns={'customer_zip_code_prefix': 'geolocation_zip_code_prefix'}, inplace=True)

location_data = pd.read_csv('../original_dataset/olist_geolocation_dataset.csv')
location_data = location_data.drop_duplicates(subset='geolocation_zip_code_prefix', keep='first')

customer_location_data = pd.merge(customer_data, location_data, on='geolocation_zip_code_prefix', how='left')

customer_location_data = customer_location_data.drop(columns=['geolocation_city', 'geolocation_state', 'geolocation_zip_code_prefix'])
customer_location_data.rename(columns={
    'geolocation_lat': 'lat',
    'geolocation_lng': 'lng',
    'customer_city': 'city',
    'customer_state': 'state'
}, inplace=True)

customer_location_data.to_csv('../processed_data/dim_customer.csv', index=False)
