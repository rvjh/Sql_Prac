with cte as(
select * 
, row_number() over(partition by customer_name order by order_date desc) rn
, count(*) over(partition by customer_name) cnt
from orders)
select order_id,order_date,customer_name,product_name,sales
from cte where cnt=1 or rn=2