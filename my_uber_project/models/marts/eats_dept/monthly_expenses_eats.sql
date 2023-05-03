-- models/marts/eats_dept/monthly_expenses_eats.sql
{{ config(materialized='table') }}

WITH monthly_eats AS (
    SELECT
        date_trunc('month', transaction_date) as month,
        COUNT(*) as num_transactions,
        SUM(total) as total_expenses
    FROM {{ ref('uber_transactions') }}
    WHERE type = 'eats'
    GROUP BY 1
)

SELECT
    month,
    num_transactions,
    total_expenses
FROM monthly_eats
ORDER BY month
