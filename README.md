* Como rodar e contribuir com os **pipelines do Apache Hop**
* Explicação da **estrutura de diretórios**
* Visão geral da **arquitetura**
* Guia de contribuição

---

````markdown
# 📦 Projeto Data Warehouse Olist

Este repositório contém um projeto completo de Data Warehouse baseado no dataset **[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)**. Ele usa o **Apache Hop** como ferramenta principal de ETL, com armazenamento analítico em **ClickHouse** e visualizações em **Superset**.

---

## 📁 Estrutura do Projeto

```plaintext
olist_dw_project/
├── README.md                        # Instruções e documentação
├── raw_csvs/                        # Arquivos originais extraídos do .sqlite ou Kaggle
│   └── olist_orders_dataset.csv
│   └── ...
├── hop_project/                     # Projeto Apache Hop
│   ├── pipelines/                   # Transformações unitárias (.hpl)
│   │   ├── transform_orders.hpl
│   │   ├── transform_customers.hpl
│   │   └── ...
│   ├── workflows/                   # Workflows para orquestração (.hwf)
│   │   └── main_etl_workflow.hwf
│   ├── metadata/                    # Conexões, variáveis e ambiente
│   └── hop-config.json              # Configuração do projeto
├── transformed/                     # Dados limpos e prontos para carga no DW
│   └── dim_cliente.csv
│   └── fato_vendas.csv
├── dw_clickhouse/                   # Scripts SQL de criação das tabelas no DW
│   └── create_dim_cliente.sql
│   └── create_fato_vendas.sql
├── dw_model_pgmodeler/             # Modelo dimensional (.dbm, imagens, etc)
├── dashboards_superset/            # Dashboards criados no Superset
└── docs/                            # Relatório, slides e materiais de apresentação
````

---

## ⚙️ Tecnologias utilizadas

| Etapa                 | Ferramenta         |
| --------------------- | ------------------ |
| ETL                   | Apache Hop         |
| Modelagem Dimensional | pgModeler          |
| Armazenamento DW      | ClickHouse         |
| Visualização          | Apache Superset    |
| Dataset               | Olist (via Kaggle) |

---

## 🏗️ Arquitetura

```plaintext
.raw_csvs/ ➜ Apache Hop ➜ .transformed/ ➜ ClickHouse ➜ Superset
```

* **Extração**: CSVs extraídos do SQLite original do Kaggle
* **Transformação (Hop)**:

  * Pipelines independentes por entidade (clientes, pedidos, produtos...)
  * Um workflow principal (`main_etl_workflow.hwf`) orquestra tudo
* **Carga**: os CSVs transformados são importados no ClickHouse como tabelas analíticas
* **Visualização**: os dashboards são feitos com Apache Superset diretamente conectado ao DW

---

## 🚀 Executando o Projeto

### 1. Clonar o repositório

```bash
git clone https://github.com/seuusuario/olist-dw-project.git
cd olist-dw-project
```

### 2. Instalar o Apache Hop

* Baixe em: [https://hop.apache.org/download](https://hop.apache.org/download)
* Extraia e execute o `hop-gui`

### 3. Configurar o projeto no Hop

1. Vá em **Project → Create Project**
2. Nome: `olist_dw_project`
3. Diretório: `./hop_project/`

> Você também pode importar os `.hpl` e `.hwf` manualmente.

### 4. Rodar os pipelines

* Abra o `Workflow` em `hop_project/workflows/main_etl_workflow.hwf`
* Clique em "Run" para executar a orquestração completa

---

## 📊 Tabelas do DW

### 🧾 Fato

| Nome         | Descrição                                          |
| ------------ | -------------------------------------------------- |
| fato\_vendas | Cada linha representa um item vendido (order item) |

### 🧱 Dimensões

* `dim_cliente`
* `dim_produto`
* `dim_data`
* `dim_vendedor`
* `dim_pagamento`
* `dim_avaliacao`

---

## 🤝 Como Contribuir

### 1. Requisitos

* Java 11 ou superior
* Apache Hop
* (opcional) pgModeler ou DB-Main
* ClickHouse (ou MySQL/PostgreSQL)

### 2. Recomendações

* Cada nova pipeline deve estar dentro de `hop_project/pipelines/`
* Nomeie com `transform_<nome>.hpl`
* Sempre valide com `Preview` antes de rodar o workflow principal

### 3. Para adicionar um novo pipeline:

1. Crie a pipeline no Hop GUI
2. Salve em `pipelines/`
3. Atualize o `main_etl_workflow.hwf` para incluí-la
4. Teste localmente

### 4. Sugestões de melhorias

* Adição de novas dimensões (ex: comportamento de review)
* Geração automatizada de relatórios com Hop ou Superset API
* Substituir arquivos CSV por tabelas intermediárias em banco

---

## 📘 Referências

* [Apache Hop Docs](https://hop.apache.org/docs/)
* [ClickHouse Docs](https://clickhouse.com/docs/)
* [Superset Docs](https://superset.apache.org/)
* [Olist Dataset Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

