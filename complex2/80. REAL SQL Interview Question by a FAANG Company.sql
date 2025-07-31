select * from transactions_goo;


with cte as(
select * 
, lead(customer_id,1) over(order by transaction_id) buyer_id
from transactions_goo
where transaction_id %2=1)
, cte2 as(
select customer_id, buyer_id, count(*) no_of_trans
from cte
group by customer_id, buyer_id)
select distinct customer_id from cte2
where customer_id in(select distinct buyer_id from cte2)
