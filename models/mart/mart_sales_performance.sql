-- models/mart/mart_sales_performance.sql

WITH order_items AS (
    SELECT
        oi.order_id,
        o.order_date,
        o.store_id,
        o.store_name,
        p.brand_id,
        p.brand_name,
        p.category_id,
        p.category_name,
        oi.quantity,
        -- Prix effectivement payé par ligne (en tenant compte de la réduction)
        oi.list_price * (1 - oi.discount) AS price_paid
    FROM {{ ref('int_local_bike_order_items') }} oi
    LEFT JOIN {{ ref('int_local_bike_orders') }} o ON oi.order_id = o.order_id
    LEFT JOIN {{ ref('int_local_bike_products') }} p ON oi.product_id = p.product_id
)

SELECT
    store_id,
    store_name,
    category_id,
    category_name,
    brand_id,
    brand_name,
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,

    COUNT(DISTINCT order_id) AS nb_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(price_paid), 2) AS total_revenue,
    ROUND(SUM(price_paid) / COUNT(DISTINCT order_id), 2) AS avg_basket

FROM order_items
GROUP BY
    store_id,
    store_name,
    category_id,
    category_name,
    brand_id,
    brand_name,
    order_year,
    order_month


