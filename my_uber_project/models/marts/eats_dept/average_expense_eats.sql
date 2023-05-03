-- models/marts/eats_dept/average_expense_eats.sql
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
    total_expenses,
    total_expenses::decimal / num_transactions as average_expense_per_order
FROM monthly_eats
ORDER BY month
