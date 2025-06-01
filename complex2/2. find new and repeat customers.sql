select * from customer_orders;


with first_visit as(
select customer_id, min(order_date) min_order_date
from customer_orders
group by customer_id)
, cte as(
select customer_orders.customer_id, customer_orders.order_date, first_visit.min_order_date
from customer_orders inner join first_visit 
on customer_orders.customer_id = first_visit.customer_id)
select order_date,
sum(case when min_order_date = order_date then 1 else 0 end) first_visit,
sum(case when min_order_date != order_date then 1 else 0 end) repeat_visit
from cte
group by order_date;

