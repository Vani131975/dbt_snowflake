SELECT
    customer_state,
    product_category_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(price) AS total_sales,
    SUM(freight_value) AS total_freight
FROM {{ ref('fct_orders') }}
GROUP BY 1, 2
