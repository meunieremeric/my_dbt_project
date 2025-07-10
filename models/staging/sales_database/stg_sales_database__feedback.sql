select
  concat(feedback_id, '_', order_id) as feedback_id,
  order_id,
  feedback_score,
  feedback_form_sent_date,
  feedback_answer_date
from {{ source('sales_database', 'feedback') }}