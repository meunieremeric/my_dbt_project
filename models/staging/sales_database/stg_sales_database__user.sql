select
  user_name as user_id,
  customer_state,
  customer_city
from {{ source('sales_database', 'user') }}