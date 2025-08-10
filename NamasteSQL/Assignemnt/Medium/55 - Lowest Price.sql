with cte as(
select products.*,purchases.stars  
from products
left join purchases on products.id = purchases.product_id)
, cte1 as(
select category, min(price) price
from cte where stars>=4
group by category)
, cte2 as(
select category, 0 as price
from cte
where category not in(select category from cte1)
group by category)
select * from cte1 
union 
select * from cte2
order by category asc