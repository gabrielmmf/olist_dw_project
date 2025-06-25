#!/bin/bash

# Solicitar senha do usuário
read -sp "🔑 Enter password for ClickHouse user 'default': " CH_PASSWORD
echo ""

# Confirmação de segurança
read -p "⚠️ Tem certeza que deseja DELETAR TODO o Data Warehouse 'olist_dw'? (y/N): " confirm
if [[ $confirm != [yY] ]]; then
    echo "❌ Operação cancelada."
    exit 1
fi

# Executar o drop de todas as tabelas e do banco
clickhouse-client --user default --password "$CH_PASSWORD" --query="
DROP DATABASE IF EXISTS olist_dw;
"

echo "🧹 Data Warehouse 'olist_dw' removido com sucesso."
