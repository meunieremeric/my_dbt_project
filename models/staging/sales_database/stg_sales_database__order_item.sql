select
  order_item,
  order_id,
  product_id,
  price,
  quantity,
  shipping_cost,

  -- calcul du montant total
  price * quantity + shipping_cost as total_order_item_amount

from {{ source('sales_database', 'order_item') }}

