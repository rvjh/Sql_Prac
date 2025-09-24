select * from customer_orders;

-- date, new customer , repeat customer

with cte as(
select customer_id, min(order_date) first_visit
from customer_orders
group by customer_id)
, cte2 as(
select customer_orders.*, cte.first_visit
from customer_orders
inner join cte on customer_orders.customer_id = cte.customer_id)
, cte3 as(
select *,
case when order_date = first_visit then 1 else 0 end flag
from cte2)
select order_date,
sum(case when flag = 1 then flag end) new_customer,
sum(case when flag = 0 then 1 else 0 end) repeated_customer
from cte3
group by order_date;