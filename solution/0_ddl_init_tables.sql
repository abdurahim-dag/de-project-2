-- Создание справочника стоимости доставки в страны

CREATE TABLE shipping_country_rates(
    shipping_country_id serial PRIMARY KEY,
    shipping_country text,
    shipping_country_base_rate NUMERIC(14,3)
);

-- Создание справочника тарифов доставки вендора по договору

CREATE TABLE shipping_agreement (
    agreement_id bigint PRIMARY KEY,
    agreement_number text,
    agreement_rate NUMERIC(2,2),
    agreement_commission NUMERIC(2,2)
);

-- Создание справочника о типах доставки

CREATE TABLE shipping_transfer(
    shipping_transfer_id serial PRIMARY KEY,
    shipping_transfer_type text,
    shipping_transfer_model text,
    shipping_transfer_rate NUMERIC(14,3)
);

-- Создание таблицы с уникальными доставками

CREATE TABLE shipping_info(
    shipping_id bigint PRIMARY KEY,
    vendor_id bigint,
    payment_amount NUMERIC(14,2),
    shipping_plan_datetime timestamp,
    transfer_id bigint references shipping_transfer(shipping_transfer_id),
    shipping_country_id bigint references shipping_country_rates(shipping_country_id),
    agreement_id bigint references shipping_agreement(agreement_id)
);

-- Создние таблицы статусов о доставке

CREATE TABLE shipping_status(
    shipping_id bigint PRIMARY KEY,
    shipping_start_fact_datetime timestamp,
    shipping_end_fact_datetime timestamp,
    "status" text,
    "state" text
);