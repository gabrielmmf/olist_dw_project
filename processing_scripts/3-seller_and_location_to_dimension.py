import pandas as pd

seller_data = pd.read_csv('../original_dataset/olist_sellers_dataset.csv')
seller_data.rename(columns={'seller_zip_code_prefix': 'geolocation_zip_code_prefix'}, inplace=True)

location_data = pd.read_csv('../original_dataset/olist_geolocation_dataset.csv')
location_data = location_data.drop_duplicates(subset='geolocation_zip_code_prefix', keep='first')

seller_location_data = pd.merge(seller_data, location_data, on='geolocation_zip_code_prefix', how='left')
seller_location_data = seller_location_data.drop(columns=['geolocation_city', 'geolocation_state', 'geolocation_zip_code_prefix'])

seller_location_data.rename(columns={
    'geolocation_lat': 'lat',
    'geolocation_lng': 'lng',
    'seller_city': 'city',
    'seller_state': 'state'
}, inplace=True)

seller_location_data.to_csv('../processed_data/dim_seller.csv', index=False)
