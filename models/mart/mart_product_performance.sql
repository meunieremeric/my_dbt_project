-- models/mart/mart_product_performance.sql

WITH order_items AS (
    SELECT
        oi.product_id,
        oi.order_id,
        p.product_name,
        p.category_id,
        p.category_name,
        p.brand_id,
        p.brand_name,
        o.store_id,
        s.store_name,
        DATE_TRUNC(o.order_date, MONTH) AS order_month,
        EXTRACT(YEAR FROM o.order_date) AS order_year,
        EXTRACT(MONTH FROM o.order_date) AS order_month_number,
        oi.quantity,
        oi.list_price,
        oi.discount,
        -- Revenue = list_price * (1 - discount) * quantity
        oi.quantity * oi.list_price * (1 - oi.discount) AS net_revenue,
        -- Effective unit price = list_price * (1 - discount)
        oi.list_price * (1 - oi.discount) AS effective_price
    FROM {{ ref('int_local_bike_order_items') }} oi
    LEFT JOIN {{ ref('int_local_bike_products') }} p ON oi.product_id = p.product_id
    LEFT JOIN {{ ref('int_local_bike_orders') }} o ON oi.order_id = o.order_id
    LEFT JOIN {{ ref('stg_local_bike_stores') }} s ON o.store_id = s.store_id
)

SELECT
    product_id,
    product_name,
    category_id,
    category_name,
    brand_id,
    brand_name,
    store_id,
    store_name,
    order_year,
    order_month_number AS order_month,
    
    COUNT(DISTINCT order_id) AS nb_orders,
    SUM(quantity) AS total_quantity,
    SUM(net_revenue) AS total_revenue,
    ROUND(AVG(discount), 4) AS avg_discount,
    ROUND(AVG(effective_price), 2) AS avg_paid_price

FROM order_items
GROUP BY
    product_id,
    product_name,
    category_id,
    category_name,
    brand_id,
    brand_name,
    store_id,
    store_name,
    order_year,
    order_month_number
