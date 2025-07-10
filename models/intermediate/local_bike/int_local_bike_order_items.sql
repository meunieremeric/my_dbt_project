SELECT
  oi.order_id,
  o.store_id,                       
  o.order_date,                       
  oi.item_id,
  oi.product_id,
  p.product_name,
  p.category_id,
  p.category_name,
  p.brand_id,
  p.brand_name,
  oi.quantity,
  oi.list_price,
  oi.discount
FROM {{ ref('stg_local_bike_order_items') }} oi
LEFT JOIN {{ ref('int_local_bike_products') }} p ON oi.product_id = p.product_id
LEFT JOIN {{ ref('int_local_bike_orders') }} o ON oi.order_id = o.order_id