SELECT
    product_id,
    product_category_name,
    product_weight_g
FROM {{ source('bronze', 'products_raw') }}
