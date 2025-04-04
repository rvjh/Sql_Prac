select * from flights;
select * from sales ;


select * from flights;
-- cid origin dest


select a.cid, a.origin as origin, b.Destination as destination
from flights a join flights b on a.Destination = b.origin;


select * from sales ;
-- no of each customers added in new month

select order_date, count(distinct customer) as num_new_cum from (
select order_date, customer ,
row_number() over(partition by customer order by order_date) rn
from sales) A
where rn=1
group by order_date;
