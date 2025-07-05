select
  product_id,
  product_category as product_category_name,
  product_name_lenght,             
  product_description_lenght,       
  product_photos_qty,
  product_volume_cm3
from {{ source('sales_database', 'product') }}