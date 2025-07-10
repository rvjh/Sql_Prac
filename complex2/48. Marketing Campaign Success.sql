select * from marketing_campaign;


WITH cte AS (
  SELECT *,
         RANK() OVER (PARTITION BY user_id ORDER BY created_at ASC) AS rn
  FROM marketing_campaign
),
first_app_purchase AS (
  SELECT * FROM cte WHERE rn = 1
),
except_first_app_purchase AS (
  SELECT * FROM cte WHERE rn > 1
)
SELECT 
  b.user_id, b.product_id, b.created_at,
  a.user_id AS first_user_id, a.product_id AS first_product_id, a.created_at AS first_created_at
FROM except_first_app_purchase b
LEFT JOIN first_app_purchase a
  ON a.user_id = b.user_id AND a.product_id = b.product_id
WHERE a.product_id IS NULL