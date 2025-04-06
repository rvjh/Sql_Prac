select * from employees;


select *,
lower(email_id) lower_id,
case when ascii(email_id) = ascii(lower(email_id)) then 1 else 0 end as rn 
from employees;

with cte as(
select *, ascii(email_id) ascii_email,
rank() over(partition by email_id order by ascii(email_id) desc) rn
from employees)
select * from cte where rn=1	