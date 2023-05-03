-- models/marts/rides_dept/weekly_expenses_rides.sql
{{ config(materialized='table') }}

WITH weekly_rides AS (
    SELECT
        date_trunc('week', transaction_date) as week,
        COUNT(*) as num_transactions,
        SUM(total) as total_expenses
    FROM {{ ref('uber_transactions') }}
    WHERE type = 'rides'
    GROUP BY 1
)

SELECT
    week,
    num_transactions,
    total_expenses
FROM weekly_rides
ORDER BY week
