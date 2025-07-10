select
  store_id,
  product_id,
  quantity
from {{ source('Local_bike', 'stocks') }}