select * from orders3;

-- top 5 products in each category 

with cte as(
select product_name, category, sum(sales) sales
from orders3
group by product_name, category),
cte2 as(
select product_name, category, round(sales,2) sales,
rank() over(partition by category order by sales desc) rn
from cte)
select product_name, category, sales from cte2 where rn<=5;



with cte as(
select product_name, category, sum(sales) total_sales,
rank() over(partition by category order by sum(sales) desc) rn
from orders3
group by product_name, category)
select category, product_name, total_sales from cte where rn<=5