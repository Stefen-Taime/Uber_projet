-- models/marts/eats_dept/weekly_expenses_eats.sql
{{ config(materialized='table') }}

WITH weekly_eats AS (
    SELECT
        date_trunc('week', transaction_date) as week,
        COUNT(*) as num_transactions,
        SUM(total) as total_expenses
    FROM {{ ref('uber_transactions') }}
    WHERE type = 'eats'
    GROUP BY 1
)

SELECT
    week,
    num_transactions,
    total_expenses
FROM weekly_eats
ORDER BY week
