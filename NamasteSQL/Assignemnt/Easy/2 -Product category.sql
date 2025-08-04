with cte as(
select * 
, case when price<100 then "Low Price"
	   when price>= 100 and price<=500 then "Medium Price"
       when price > 500 then "High Price"
       end as category
from products)
select category, count(*) no_of_products
from cte
group by category
order by count(*) desc;