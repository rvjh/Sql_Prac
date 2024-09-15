create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

select * from customer_orders;

-- find new and repeat customer

-- 1st time customer ordered

with cte as(
select customer_id, min(order_date) as first_visit_date
from customer_orders
group by customer_id
)
select customer_orders.order_date 
, sum(case when customer_orders.order_date = cte.first_visit_date then 1 else 0 end) as First_Visit
, sum(case when customer_orders.order_date != cte.first_visit_date then 1 else 0 end) as Second_Visit
from 
cte inner join customer_orders on cte.customer_id = customer_orders.customer_id
group by customer_orders.order_date


