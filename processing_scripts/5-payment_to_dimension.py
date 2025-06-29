import pandas as pd

payment_data = pd.read_csv('../original_dataset/olist_order_payments_dataset.csv')

payment_data.rename(columns={'payment_sequential': 'n_payment_methods'}, inplace=True)
payment_data.rename(columns={'payment_type': 'payment_method'}, inplace=True)
payment_data.rename(columns={'payment_installments': 'n_installments'}, inplace=True)

payment_data['payment_id'] = payment_data.index + 1

payment_data.to_csv('../processed_data/dim_payment.csv', index=False)
