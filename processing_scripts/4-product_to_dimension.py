import pandas as pd

product_data = pd.read_csv('../original_dataset/olist_products_dataset.csv')

product_data = product_data.drop(columns=['product_name_lenght', 'product_description_lenght', 'product_photos_qty'])

product_data.rename(columns={
    'product_category_name': 'category',
    'product_weight_g': 'weight_g',
    'product_length_cm': 'length_cm',
    'product_height_cm': 'height_cm',
    'product_width_cm': 'width_cm'
}, inplace=True)

product_data = product_data.dropna(subset=['category', 'weight_g', 'length_cm', 'height_cm', 'width_cm'])

product_data.to_csv('../processed_data/dim_product.csv', index=False)
