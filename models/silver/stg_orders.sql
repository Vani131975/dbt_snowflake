{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

SELECT
    order_id,
    customer_id,
    UPPER(order_status) AS order_status,

    TO_TIMESTAMP(order_purchase_timestamp) AS order_purchase_timestamp,

    TO_TIMESTAMP(order_approved_at) AS order_approved_at,

    TO_TIMESTAMP(order_delivered_customer_date)
        AS order_delivered_customer_date

FROM {{ source('bronze', 'orders_raw') }}

{% if is_incremental() %}

WHERE TO_TIMESTAMP(order_purchase_timestamp)
>
(
    SELECT MAX(order_purchase_timestamp)
    FROM {{ this }}
)

{% endif %}