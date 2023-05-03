-- models/marts/eats_dept/top_restaurant_orders.sql
{{ config(materialized='table') }}

WITH restaurant_orders AS (
    SELECT
        restaurant,
        COUNT(*) as num_orders
    FROM {{ ref('uber_transactions') }}
    WHERE type = 'eats'
    GROUP BY 1
)

SELECT
    restaurant,
    num_orders
FROM restaurant_orders
ORDER BY num_orders DESC
LIMIT 1
