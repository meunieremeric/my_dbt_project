select
  concat(feedback_id, '_', order_id) as feedback_id,
  order_id,
  feedback_score,
  feedback_comment_title,
  feedback_comment_message,
  datetime(feedback_date, "Europe/Paris") as feedback_date
from {{ source('sales_database', 'feedback') }}