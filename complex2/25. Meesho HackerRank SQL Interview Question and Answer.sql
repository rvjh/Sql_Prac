select * from products;
select * from customer_budget;

-- how many products in the customer budget
-- in case clash choose lees costly product

select * from products;

with r_cost as(
select *,
sum(cost) over(order by product_id) c_sum
from products)
select customer_id, budget, count(1) no_of_prods, group_concat(product_id) 
from customer_budget
left join r_cost on r_cost.c_sum < customer_budget.budget
group by customer_id, budget;



