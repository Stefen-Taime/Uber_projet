-- models/marts/rides_dept/monthly_expenses_rides.sql
{{ config(materialized='table') }}

WITH monthly_rides AS (
    SELECT
        date_trunc('month', transaction_date) as month,
        COUNT(*) as num_transactions,
        SUM(total) as total_expenses
    FROM {{ ref('uber_transactions') }}
    WHERE type = 'rides'
    GROUP BY 1
)

SELECT
    month,
    num_transactions,
    total_expenses
FROM monthly_rides
ORDER BY month
