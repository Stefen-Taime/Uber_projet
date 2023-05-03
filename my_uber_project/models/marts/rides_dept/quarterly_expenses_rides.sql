-- models/marts/rides_dept/quarterly_expenses_rides.sql
{{ config(materialized='table') }}

WITH quarterly_rides AS (
    SELECT
        date_trunc('quarter', transaction_date) as quarter,
        COUNT(*) as num_transactions,
        SUM(total) as total_expenses
    FROM {{ ref('uber_transactions') }}
    WHERE type = 'rides'
    GROUP BY 1
)

SELECT
    quarter,
    num_transactions,
    total_expenses
FROM quarterly_rides
ORDER BY quarter
