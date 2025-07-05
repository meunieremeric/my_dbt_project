select
  product_id,
  product_category as product_category_name,
  product_name_lenght,
  product_description_lenght,
  product_photos_qty,
  product_weight_g,
  product_length_cm,
  product_height_cm,
  product_width_cm,
  
  -- Calcul du volume en cm³ (longueur × largeur × hauteur)
  product_length_cm * product_width_cm * product_height_cm as product_volume_cm3

from {{ source('sales_database', 'product') }}
