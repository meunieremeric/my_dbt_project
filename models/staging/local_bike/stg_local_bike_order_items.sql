select
  order_id,
  item_id,
  product_id,
  quantity,
  list_price,
  discount
from {{ source('Local_bike', 'order_items') }}