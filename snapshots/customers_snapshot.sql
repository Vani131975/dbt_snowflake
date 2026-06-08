{% snapshot customers_snapshot %}

{{
    config(
      target_schema='SNAPSHOTS',
      unique_key='customer_id',
      strategy='check',
      check_cols=['customer_city','customer_state']
    )
}}

SELECT *
FROM {{ ref('stg_customers') }}

{% endsnapshot %}