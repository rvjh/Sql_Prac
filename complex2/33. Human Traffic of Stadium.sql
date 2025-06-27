-- 3 or more consecutive rows where more than 100 people each day

select * from stadium;


with cte as(
select *,
id - row_number() over(order by visit_date) grp
from stadium
where no_of_people >=100)
select * from cte
where grp in
(select grp
from cte
group by grp
having count(1)>=3);