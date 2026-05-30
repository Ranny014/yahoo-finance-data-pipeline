CREATE SCHEMA IF NOT EXISTS yahoo_finance;

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