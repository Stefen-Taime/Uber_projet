-- models/marts/rides_dept/yearly_expenses_rides.sql
{{ config(materialized='table') }}

WITH yearly_rides AS (
    SELECT
        date_trunc('year', transaction_date) as year,
        COUNT(*) as num_transactions,
        SUM(total) as total_expenses
    FROM {{ ref('uber_transactions') }}
    WHERE type = 'rides'
    GROUP BY 1
)

SELECT
    year,
    num_transactions,
    total_expenses
FROM yearly_rides
ORDER BY year
