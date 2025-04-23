select * from orders3;

with cte as (
select customer_name, sum(sales) as total_sales
from orders3
group by customer_name),
ranked_cte as (
select customer_name, total_sales, 
ntile(100) over (order by total_sales desc) as percentile_rank
from cte
)
select customer_name, total_sales, 
case when percentile_rank <= 25 then 'Top 25%'
	 when percentile_rank > 75 then 'Bottom 25%'
	 else 'Middle 50%' end as category
from ranked_cte
where percentile_rank <= 25 or percentile_rank > 75;