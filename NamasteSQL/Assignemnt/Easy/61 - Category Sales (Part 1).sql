with cte as(
select * 
from sales
where year(order_date)=2022 and month(order_date)=2)
select category, sum(amount) total_sales 
from cte
where weekday(order_date) not in (5,6)
group by category
order by sum(amount) asc;