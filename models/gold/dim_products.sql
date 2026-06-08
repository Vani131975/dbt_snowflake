SELECT
    product_id,
    product_category_name,
    product_weight_g
FROM {{ ref('stg_products') }}
