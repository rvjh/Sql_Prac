with cte as(
select month(invoicedate) month, description,
sum(unitprice * quantity) total_paid 
from online_retail
group by month(invoicedate), description)
, cte2 as(
select * 
, row_number() over(partition by month order by total_paid desc) rn
from cte)
select month, description, total_paid from cte2 where rn=1