# 🚀 Yahoo Finance Batch Data Pipeline

## 📌 Project Overview

This project is an end-to-end **batch data engineering pipeline** that collects historical stock market data from Yahoo Finance using Python (yFinance), stores it in PostgreSQL, sends data to Kafka, processes it using Spark, and finally stores the transformed data into MinIO Data Lake.

The pipeline is built using Apple Inc. (AAPL) stock data as a sample dataset.

---

## 🏗️ Architecture

```text
Yahoo Finance (yFinance)
          |
          v
Ingestion Layer (Python Script)
          |
          v
PostgreSQL (Raw Storage)
          |
          v
Kafka (Data Streaming Layer)
          |
          v
Spark Processing (Batch/Stream ETL)
          |
          v
MinIO Data Lake
```


---

## 📂 Project Structure

```
yahoo-finance-data-pipeline/

├── ingestion/
│   └── yfinance_to_postgres.ipynb
│
├── postgres/
│   └── schema.sql
│
├── kafka/
│   └── postgres_to_kafka.ipynb
│
├── spark/
│   └── spark_stream.ipynb
│
|
├── screenshot
├── docker-compose.yaml
├── requirements.txt
└── README.md
```

---

## ⚙️ Technology Stack

| Layer | Technology |
|------|------------|
| Data Source | Yahoo Finance |
| Ingestion | Python, yFinance |
| Database | PostgreSQL |
| Messaging | Apache Kafka |
| Processing | Apache Spark |
| Data Lake | MinIO |
| Format | Parquet |
| Containerization | Docker |

---

## 📊 Data Source

Data is extracted from Yahoo Finance using `yfinance`.

```python
import yfinance as yf

symbol = "AAPL"

df = yf.download(
    symbol,
    start="2023-01-01",
    end="2025-01-01",
    interval="1d",
    progress=False,
    threads=False
)
```

---

## 🧾 PostgreSQL Schema

```sql
CREATE TABLE IF NOT EXISTS yahoo_finance.stock_price (
    id SERIAL PRIMARY KEY,
    symbol TEXT,
    date DATE,
    open FLOAT,
    high FLOAT,
    low FLOAT,
    close FLOAT,
    volume BIGINT,
    return FLOAT,
    volatility_20d FLOAT
);
```

---

## 📚 Pipeline Workflow

### 1. Ingestion (yFinance → PostgreSQL)
- Extract historical stock data using yFinance
- Store into PostgreSQL table stock_price
- Acts as raw data storage layer

### 2. PostgreSQL → Kafka
- Read data from PostgreSQL
- Publish records into Kafka topic:
```
yahoo_finance
```
- Enables decoupled data streaming between systems

### 3. Spark Processing → MinIO
- Consume data from Kafka using Spark
- Perform transformations:
    * Data cleaning
    * Feature engineering
    * Deduplication

## ✨ Feature Engineering:

- Daily Return
- 20-day Volatility
- Store results into MinIO as Parquet files

## 🗄️ Batch Processing Flow

Although Kafka and Spark are used, execution is batch-oriented:
```
Step 1: Run ingestion (yFinance → PostgreSQL)
Step 2: Run PostgreSQL → Kafka producer
Step 3: Run Spark job → MinIO storage
```

---

## 🐳 How to Run

### 1. Start Infrastructure
```bash
docker compose up -d
```

### 2. Run Ingestion
```bash
python ingestion/yfinance_to_postgres.ipynb
```

### 3. Send Data to Kafka
```bash
python kafka/postgres_to_kafka.ipynb
```

### 4. Run Spark Job
```bash
spark-submit spark/spark_stream.ipynb
```

---

## 🔥 Key Features

- End-to-end data pipeline
- Yahoo Finance data ingestion
- PostgreSQL raw storage
- Kafka data streaming layer
- Spark processing engine
- MinIO data lake storage
- Feature engineering (return & volatility)
- Batch execution workflow

---

## 🧠 Skills Demonstrated

- Python Data Engineering
- ETL Pipeline Design
- PostgreSQL Data Modeling
- Apache Kafka
- Apache Spark
- Data Lake Architecture
- Time Series Processing
- Batch Data Processing
- Docker-based Infrastructure

---

## 📈 Future Improvements

- Apache Airflow orchestration
- Real-time streaming mode optimization
- Data quality checks (Great Expectations)
- Dashboard (Metabase / Superset)
- Multi-stock support (AAPL, MSFT, TSLA)
- CI/CD pipeline integration

---

## 👨‍💻 Author

GitHub: https://github.com/Ranny014