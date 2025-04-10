select * from products;


select * ,
sum(cost) over(order by cost asc) r_sum
from products;
-- or
select * ,
sum(cost) over(order by cost asc, product_id) r_sum
from products;