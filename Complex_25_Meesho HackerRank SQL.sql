use test1;

select * from customer_budget;
select * from products;

-- how many products falls into customer budget along with the list of products
-- in case of clash choose less costly product

select * from customer_budget;

with running_cost as(
select *,
sum(cost) over(order by cost asc) r_cost
from products) 
select * from customer_budget cb
left join running_cost rc on rc.r_cost < cb.budget; 


WITH running_cost AS (
    SELECT *,
           SUM(cost) OVER (ORDER BY cost ASC) AS r_cost
    FROM products
)
SELECT cb.customer_id,
       cb.budget,
       COUNT(1) AS no_of_products,
       GROUP_CONCAT(rc.product_id SEPARATOR ',') AS list_of_prod
FROM customer_budget cb
LEFT JOIN running_cost rc ON rc.r_cost < cb.budget
GROUP BY cb.customer_id, cb.budget;

