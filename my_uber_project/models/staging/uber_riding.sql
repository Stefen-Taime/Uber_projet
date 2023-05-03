{{ config(materialized='table') }}
SELECT *,
       {{ parse_custom_date('date') }} as transaction_date
FROM {{ ref('uber_ride') }}
