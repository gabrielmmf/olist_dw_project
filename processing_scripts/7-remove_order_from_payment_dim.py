import pandas as pd

payments = pd.read_csv('../processed_data/dim_payment.csv')
payments = payments.drop(columns=['order_id'])
payments.to_csv('../processed_data/dim_payment.csv', index=False)
