-- int_local_bike_orders.sql
SELECT
  o.order_id,
  o.customer_id,
  c.first_name AS customer_first_name,
  c.last_name AS customer_last_name,
  o.order_status,
  o.order_date,
  o.required_date,
  o.shipped_date,
  o.store_id,
  s.store_name,
  o.staff_id,
  sf.first_name AS staff_first_name,
  sf.last_name AS staff_last_name
FROM {{ ref('stg_local_bike_orders') }} o
LEFT JOIN {{ ref('stg_local_bike_customers') }} c ON o.customer_id = c.customer_id
LEFT JOIN {{ ref('stg_local_bike_stores') }} s ON o.store_id = s.store_id
LEFT JOIN {{ ref('stg_local_bike_staffs') }} sf ON o.staff_id = sf.staff_id