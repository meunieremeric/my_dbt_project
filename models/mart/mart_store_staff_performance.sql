WITH order_lines AS (
  SELECT
    oi.order_id,
    o.store_id,
    s.store_name,
    o.staff_id,
    sf.first_name AS staff_first_name,
    sf.last_name AS staff_last_name,
    sf.manager_id,
    DATE_TRUNC(o.order_date, MONTH) AS order_month,
    oi.quantity,
    oi.list_price,
    oi.discount
  FROM {{ ref('int_local_bike_order_items') }} oi
  LEFT JOIN {{ ref('int_local_bike_orders') }} o ON oi.order_id = o.order_id
  LEFT JOIN {{ ref('stg_local_bike_stores') }} s ON o.store_id = s.store_id
  LEFT JOIN {{ ref('stg_local_bike_staffs') }} sf ON o.staff_id = sf.staff_id
)


SELECT
store_id,
store_name,
staff_id,
staff_first_name,
staff_last_name,
manager_id,
order_month,
COUNT(DISTINCT order_id) AS order_count,
SUM(quantity) AS total_quantity,
SUM(quantity * list_price * (1 - discount)) AS revenue,
SAFE_DIVIDE(SUM(quantity * list_price * (1 - discount)), COUNT(DISTINCT order_id)) AS average_basket
FROM order_lines
GROUP BY store_id, store_name, staff_id, staff_first_name, staff_last_name, manager_id, order_month
