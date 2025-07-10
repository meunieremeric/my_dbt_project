-- int_local_bike_stocks.sql
SELECT
  st.store_id,
  s.store_name,
  st.product_id,
  p.product_name,
  p.brand_id,
  p.brand_name,
  p.category_id,
  p.category_name,
  st.quantity
FROM {{ ref('stg_local_bike_stocks') }} st
LEFT JOIN {{ ref('int_local_bike_products') }} p ON st.product_id = p.product_id
LEFT JOIN {{ ref('stg_local_bike_stores') }} s ON st.store_id = s.store_id



