SELECT
    order_id,
    product_id,
    seller_id,

    TO_TIMESTAMP(shipping_limit_date)
        AS shipping_limit_date,

    price::NUMBER(10,2) AS price,
    freight_value::NUMBER(10,2) AS freight_value

FROM {{ source('bronze', 'order_items_raw') }}