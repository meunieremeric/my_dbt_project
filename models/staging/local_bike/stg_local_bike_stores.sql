select
  store_id,
  store_name,
  phone,
  email,
  street,
  city,
  state,
  zip_code
from {{ source('Local_bike', 'stores') }}