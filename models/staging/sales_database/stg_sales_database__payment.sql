select
  concat(order_id, '_', payment_sequential) as payment_id,
  order_id,
  payment_sequential,
  payment_type,
  payment_installments,
  payment_value
from {{ source('sales_database', 'payment') }}
