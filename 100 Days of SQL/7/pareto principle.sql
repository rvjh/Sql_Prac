select * from orders3;

-- 80% of sales 20% product

-- 80% sales
select sum(sales) *0.8 80_per_sales from orders3;   -- 1501582.5083043575

with cte as(
select product_id, sum(sales) prod_sales 
from orders3
group by product_id
order by prod_sales desc)
, cte2 as(
select product_id, prod_sales,
sum(prod_sales) over(order by prod_sales desc 
					 rows between unbounded preceding and 0 preceding) total_cum_sum
from cte
group by product_id)
select product_id as 20_per_products 
from cte2 
where total_cum_sum <= (select sum(sales) *0.8  from orders3)

