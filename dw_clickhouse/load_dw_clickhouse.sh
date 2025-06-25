#!/bin/bash

# Caminho para os arquivos
SQL_SCRIPT="create_and_insert_dw.sql"
TRANSFORMED_DIR="../dw_transformed"

# Solicitar senha ao usuário
read -sp "🔑 Enter password for ClickHouse user 'default': " CH_PASSWORD
echo ""

# Verifica se clickhouse-client está disponível
if ! command -v clickhouse-client &> /dev/null
then
    echo "❌ clickhouse-client não encontrado. Verifique se está instalado e no PATH."
    exit 1
fi

echo "✅ Iniciando carga no Data Warehouse (olist_dw)..."

# Executar script SQL para criação das tabelas
echo "🚧 Criando tabelas no banco de dados..."
clickhouse-client --password "$CH_PASSWORD" --user default < "$SQL_SCRIPT"

# Lista de arquivos e tabelas
declare -A tables
tables[dim_customer]="dim_customer.csv"
tables[dim_date]="dim_date.csv"
tables[dim_product]="dim_product.csv"
tables[dim_seller]="dim_seller.csv"
tables[dim_location]="dim_location.csv"
tables[dim_payment]="dim_payment.csv"
tables[dim_review]="dim_review.csv"
tables[fct_sales]="fct_sales.csv"
tables[fct_reviews]="fct_reviews.csv"
tables[fct_payments]="fct_payments.csv"

# Inserir os dados
for table in "${!tables[@]}"; do
    file="${TRANSFORMED_DIR}/${tables[$table]}"
    if [ -f "$file" ]; then
        echo "📤 Inserindo dados em: $table"
        clickhouse-client --user default --password "$CH_PASSWORD" --query="INSERT INTO olist_dw.${table} FORMAT CSVWithNames" < "$file"
    else
        echo "⚠️  Arquivo não encontrado: $file"
    fi
done

echo "✅ Carga finalizada com sucesso."
