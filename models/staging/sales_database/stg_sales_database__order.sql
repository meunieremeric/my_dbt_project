select
  order_id,
  user_name as user_id,
  order_status,
  datetime(order_date, "Europe/Paris") as order_created_at,
  datetime(order_approved_date, "Europe/Paris") as order_approved_at,
  datetime(pickup_date, "Europe/Paris") as picked_up_at,
  datetime(delivered_date, "Europe/Paris") as delivered_at,
  datetime(estimated_time_delivery, "Europe/Paris") as estimated_time_delivery
from {{ source('sales_database', 'order') }}
