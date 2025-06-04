select * from orders3;

-- pareto which 20% of products gives 80% of sales


with total_product_sales as(
select product_id, sum(sales) total_Sales
from orders3
group by product_id),
cte2 as(
select product_id,total_Sales,
sum(total_Sales) over(order by product_id desc rows between unbounded preceding and 0 preceding) run_sum,
0.8*sum(total_Sales) over() total_sales_80
from total_product_sales)
select product_id from cte2 where run_sum < total_sales_80;







