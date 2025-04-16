select * from products;

--  running cost

select *, sum(cost) over(order by product_id) rcost from products;


select *, 
sum(cost) over(order by product_id rows between unbounded preceding and current row) rcost 
from products;



