-- Step 1: Retrieve current stock levels with product and store details
WITH current_stock AS (
  SELECT
    store_id,
    store_name,
    product_id,
    product_name,
    brand_id,
    brand_name,
    category_id,
    category_name,
    quantity AS current_stock
  FROM {{ ref('int_local_bike_stocks') }}
),

-- Step 2: Calculate total quantity sold per product/store in the last 30 days
recent_sales AS (
  SELECT
    oi.store_id,
    oi.product_id,
    SUM(oi.quantity) AS total_quantity_sold_last_30d
  FROM {{ ref('int_local_bike_order_items') }} oi
  JOIN {{ ref('int_local_bike_orders') }} o
    ON oi.order_id = o.order_id
  WHERE o.order_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
  GROUP BY oi.store_id, oi.product_id
),

-- Step 3: Join stock with recent sales
stock_with_sales AS (
  SELECT
    cs.*,
    COALESCE(rs.total_quantity_sold_last_30d, 0) AS total_quantity_sold_last_30d
  FROM current_stock cs
  LEFT JOIN recent_sales rs
    ON cs.store_id = rs.store_id AND cs.product_id = rs.product_id
)

-- Step 4: Assign stock status labels based on business rules
SELECT
  product_id,
  product_name,
  category_id,
  category_name,
  brand_id,
  brand_name,
  store_id,
  store_name,
  current_stock,
  total_quantity_sold_last_30d,

  CASE
    WHEN current_stock = 0 THEN 'out_of_stock'
    WHEN current_stock < 3 THEN 'low_stock'
    WHEN current_stock > 20 AND total_quantity_sold_last_30d < 2 THEN 'overstock'
    ELSE 'ok'
  END AS stock_status

FROM stock_with_sales
