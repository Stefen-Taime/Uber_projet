-- models/marts/rides_dept/average_expense_rides.sql
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
    total_expenses,
    total_expenses::decimal / num_transactions as average_expense_per_ride
FROM monthly_rides
ORDER BY month
