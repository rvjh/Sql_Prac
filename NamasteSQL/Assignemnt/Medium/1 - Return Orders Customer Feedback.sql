with cte as(
select orders.*,returns.return_date,
case when return_date is null then 0 else 1 end as return_flag
from orders
left join returns on orders.order_id = returns.order_id)
, cte2 as(
select
customer_name, count(*) total_orders,
sum(return_flag) total_return_order
from cte
group by customer_name)
select customer_name, 
round(total_return_order/total_orders * 100,2) return_percent
from cte2
where round(total_return_order/total_orders * 100,2) >50;

