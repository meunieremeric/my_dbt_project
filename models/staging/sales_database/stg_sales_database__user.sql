select
  user_name as user_id,
  customer_state,
  customer_city,
  customer_zip_code_prefix
from {{ source('sales_database', 'user') }}