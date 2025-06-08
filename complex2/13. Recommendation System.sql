select * from orders_2;
select * from products_2;

WITH cte AS (
    SELECT o1.order_id, o1.product_id AS p1, o2.product_id AS p2  
    FROM orders_2 o1  
    INNER JOIN orders_2 o2 ON o1.order_id = o2.order_id  
    WHERE o1.product_id < o2.product_id
), 
cte2 AS (
    SELECT cte.order_id, 
           p1_product.name AS p1_name, 
           p2_product.name AS p2_name
    FROM cte
    INNER JOIN products_2 AS p1_product ON cte.p1 = p1_product.id
    INNER JOIN products_2 AS p2_product ON cte.p2 = p2_product.id
)
SELECT CONCAT(p1_name, '', p2_name) AS product_pairs, 
       count(1) total_purchase
FROM cte2
group by CONCAT(p1_name, '', p2_name);






