-- models/intermediate/uber_transactions.sql
{{ config(materialized='table') }}
WITH eats AS (
    SELECT 'eats' as type,
           transaction_date,
           total,
           restaurant
    FROM {{ ref('uber_eating') }}
),
rides AS (
    SELECT 'rides' as type,
           transaction_date,
           total,
           driver
    FROM {{ ref('uber_riding') }}
)
SELECT *
FROM eats
UNION ALL
SELECT *
FROM rides
