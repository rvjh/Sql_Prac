WITH cte AS (
SELECT sales.*, categories.category_name
FROM categories
LEFT JOIN sales 
ON categories.category_id = sales.category_id
),
cte2 AS (
SELECT *, 
CASE WHEN sale_id IS NULL THEN 0 
     ELSE amount 
     END AS updated_amount
  FROM cte)
SELECT category_name, sum(updated_amount) total_sales FROM cte2
group by category_name
order by sum(updated_amount) asc;