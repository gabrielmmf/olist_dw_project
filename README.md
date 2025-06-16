# 📦 olist_dw_project

Projeto de construção de um **Data Warehouse (DW)** baseado no [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). Toda a engenharia de dados é realizada com **Apache Hop**, com armazenamento analítico em **ClickHouse** e visualização interativa via **Apache Superset**.

---

## 📁 Estrutura do Projeto

A raiz do projeto é um projeto Apache Hop válido contendo `project-config.json`, pipelines, workflows, metadados e dados organizados.

```plaintext
olist_dw_project/
├── project-config.json              # Configuração principal do projeto Apache Hop
├── metadata/                        # Metadados do projeto (conexões, variáveis, ambientes)
├── pipelines/                       # Pipelines de transformação (ETL)
│   ├── transform_orders.hpl
│   ├── transform_customers.hpl
│   ├── transform_products.hpl
│   ├── transform_reviews.hpl
│   ├── transform_payments.hpl
│   ├── generate_fato_vendas.hpl
│   └── ...
├── workflows/                       # Workflows de orquestração
│   └── main_etl_workflow.hwf
├── original_dataset/                # Dataset bruto exportado do arquivo SQLite da Olist
│   ├── olist_orders_dataset.csv
│   ├── olist_order_items_dataset.csv
│   ├── olist_customers_dataset.csv
│   ├── ...
├── transformed/                     # Arquivos CSV transformados prontos para carga no DW
│   ├── dim_cliente.csv
│   ├── dim_produto.csv
│   ├── fato_vendas.csv
│   └── ...
├── dw_model_pgmodeler/              # Modelo dimensional criado no pgModeler
│   ├── modelo_estrelado.dbm
│   └── modelo_estrelado.png
├── dw_clickhouse/                   # Scripts SQL para criação das tabelas no DW
│   ├── create_dim_cliente.sql
│   ├── create_fato_vendas.sql
│   └── ...
├── dashboards_superset/             # Dashboards criados no Superset (opcionalmente exportados)
│   └── dashboard_vendas.json
└── docs/                            # Documentação, slides, relatório final
    ├── relatorio.pdf
    └── apresentacao.pptx
````

---

## 🧱 Arquitetura Geral

```plaintext
original_dataset/ ➜ Apache Hop ➜ transformed/ ➜ ClickHouse ➜ Superset
```

### Etapas:

* **Extração**: CSVs extraídos do SQLite da Olist
* **Transformação**: pipelines Apache Hop para derivar dimensões, medidas e tabelas limpas
* **Carga**: dados transformados são importados no ClickHouse
* **Visualização**: dashboards com Apache Superset, conectados ao DW

---

## 🔁 Pipelines e Workflows

### 🧩 Pipelines (`pipelines/`)

Cada pipeline lida com uma transformação de dados específica:

* `transform_orders.hpl`: limpa e deriva dados de pedidos
* `transform_customers.hpl`: extrai dados únicos de clientes
* `transform_products.hpl`: inclui categorias e limpa nomes
* `transform_reviews.hpl`: trata avaliações e tempos de resposta
* `transform_payments.hpl`: agrega tipos de pagamento por pedido
* `generate_fato_vendas.hpl`: cria a tabela fato centralizada
* Outros pipelines podem ser adicionados conforme necessidade

### 🔁 Workflow (`workflows/`)

* `main_etl_workflow.hwf`: orquestra a execução de todos os pipelines na sequência correta, da extração à geração final dos arquivos em `transformed/`

---

## 🧠 Modelagem Dimensional

O DW foi modelado em **esquema estrela**, com base nos 4 passos de Kimball:

### 1. Processo de negócio modelado:

* **Vendas (pedidos com itens)**

### 2. Granularidade:

* Um registro por **item de pedido vendido**

### 3. Dimensões utilizadas:

* `dim_cliente` (cliente)
* `dim_produto` (produto + categoria)
* `dim_vendedor` (vendedor)
* `dim_data` (datas de compra e entrega)
* `dim_pagamento` (formas de pagamento)
* `dim_avaliacao` (score, tempo de resposta)

### 4. Fatos numéricos:

* Quantidade por item (`order_item_id`)
* Preço (`price`)
* Frete (`freight_value`)
* Total (`price + freight`)
* Dias de entrega (`entrega - compra`)
* Score da avaliação

Diagrama criado em `pgModeler` disponível em `dw_model_pgmodeler/modelo_estrelado.png`

---

## 🚀 Executando o Projeto

### 1. Clonar o repositório

```bash
git clone https://github.com/seuusuario/olist_dw_project.git
cd olist_dw_project
```

### 2. Instalar o Apache Hop

* Site oficial: [https://hop.apache.org/download/](https://hop.apache.org/download/)
* Extraia e execute o `hop-gui`

### 3. Abrir o projeto no Hop

1. Vá em `Project → Open Project`
2. Selecione o diretório que contém o `project-config.json` (a raiz deste projeto)

### 4. Rodar o workflow principal

* Abra `workflows/main_etl_workflow.hwf`
* Clique em "Run" (ou pressione `F8`)
* Os arquivos finais serão gerados em `transformed/`

---

## 🧾 Tabelas no DW

### Tabela Fato

| Nome          | Descrição                               |
| ------------- | --------------------------------------- |
| `fato_vendas` | Registro de cada item de pedido vendido |

### Dimensões

| Dimensão        | Atributos principais                       |
| --------------- | ------------------------------------------ |
| `dim_cliente`   | cidade, estado, ID do cliente              |
| `dim_produto`   | categoria, nome da categoria traduzida     |
| `dim_vendedor`  | cidade e estado do vendedor                |
| `dim_data`      | data, mês, ano, dia da semana              |
| `dim_pagamento` | tipo de pagamento, parcelas, valor         |
| `dim_avaliacao` | score, tempo de resposta, comentário limpo |

---

## 📊 Visualização (Superset)

* Conecte o Superset ao banco ClickHouse com as tabelas geradas
* Crie dashboards com métricas como:

  * Volume de vendas por categoria
  * Score médio por estado
  * Tempo médio de entrega por mês
  * Distribuição de tipos de pagamento

---

## 🤝 Contribuindo

### Pré-requisitos

* Apache Hop
* pgModeler (para editar o modelo ER)
* ClickHouse (ou outro DW analítico local)

### Regras para contribuição

1. Use nomes consistentes para pipelines e arquivos
2. Coloque novas transformações em `pipelines/`
3. Atualize o `main_etl_workflow.hwf` se necessário
4. Teste localmente com `Preview` antes de rodar a workflow
5. Documente qualquer alteração no `README.md` ou crie um `CHANGELOG.md`

---

## 📘 Referências

* [Apache Hop Docs](https://hop.apache.org/docs/)
* [ClickHouse Docs](https://clickhouse.com/docs/)
* [Superset Docs](https://superset.apache.org/)
* [Olist Dataset no Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
