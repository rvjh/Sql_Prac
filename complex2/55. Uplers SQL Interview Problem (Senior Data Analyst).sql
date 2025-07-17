select * from candidates_v2;


-- budget 50000

with cte as(
select *,
row_number() over(partition by positions order by salary asc) rn
from candidates_v2)
, cte2 as(
select *,
sum(salary) over(partition by positions order by rn) c_sum
from cte)
, cte_seniors as(
select * from cte2 where c_sum<50000 and positions = 'senior')
-- select * from cte_seniors
, remaining_bal as(
select (50000 - (select sum(salary) from cte_seniors)))
-- select * from remaining_bal
, cte_juniors as(
select * from cte2 where c_sum<(select * from remaining_bal) and positions = 'junior')
select
sum(case when positions = 'senior' then 1 else 0 end) as no_of_seniors,
sum(case when positions = 'junior' then 1 else 0 end) as no_of_seniors
from(
select * from cte_juniors
union all
select * from cte_seniors) A;



