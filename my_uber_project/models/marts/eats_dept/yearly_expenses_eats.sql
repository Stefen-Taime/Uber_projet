-- models/marts/eats_dept/yearly_expenses_eats.sql
{{ config(materialized='table') }}

WITH yearly_eats AS (
    SELECT
        date_trunc('year', transaction_date) as year,
        COUNT(*) as num_transactions,
        SUM(total) as total_expenses
    FROM {{ ref('uber_transactions') }}
    WHERE type = 'eats'
    GROUP BY 1
)

SELECT
    year,
    num_transactions,
    total_expenses
FROM yearly_eats
ORDER BY year
