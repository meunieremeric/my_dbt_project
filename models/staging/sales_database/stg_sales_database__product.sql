select
  product_id,
  product_category_name,
  product_name_length,
  product_description_length,
  product_photos_qty,
  product_volume_cm3
from {{ source('sales_database', 'product') }}