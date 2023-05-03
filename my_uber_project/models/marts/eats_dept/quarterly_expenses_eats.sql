-- models/marts/eats_dept/quarterly_expenses_eats.sql
{{ config(materialized='table') }}

WITH quarterly_eats AS (
    SELECT
        date_trunc('quarter', transaction_date) as quarter,
        COUNT(*) as num_transactions,
        SUM(total) as total_expenses
    FROM {{ ref('uber_transactions') }}
    WHERE type = 'eats'
    GROUP BY 1
)

SELECT
    quarter,
    num_transactions,
    total_expenses
FROM quarterly_eats
ORDER BY quarter
