{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge'
) }}

WITH cleaned AS (
    SELECT
        order_id,
        customer_id,
        UPPER(order_status) AS order_status,
        TO_TIMESTAMP(order_purchase_timestamp) AS order_purchase_timestamp
    FROM {{ source('bronze', 'orders_raw') }}
    WHERE order_id IS NOT NULL
),

deduped AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY order_id
               ORDER BY order_purchase_timestamp DESC
           ) AS rn
    FROM cleaned
)

SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp
FROM deduped
WHERE rn = 1