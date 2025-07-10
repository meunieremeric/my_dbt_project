select
  brand_id,
  brand_name
from {{ source('Local_bike', 'brands') }}