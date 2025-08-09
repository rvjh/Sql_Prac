SELECT 
  o.product_id,
  SUM(p.price) AS total_sales_value
FROM orders o
JOIN products p 
  ON o.product_id = p.product_id
  AND p.price_date = (
    SELECT MAX(price_date)
    FROM products p2
    WHERE p2.product_id = o.product_id
      AND p2.price_date <= o.order_date
  )
GROUP BY o.product_id
ORDER BY o.product_id ASC;