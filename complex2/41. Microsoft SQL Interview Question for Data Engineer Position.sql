select * from candidates;



-- 70000

with cte as(
select *,
sum(salary) over(partition by experience order by salary asc
				rows between unbounded preceding and current row) r_sum
from candidates)
, cte_senior as(
select * from cte where experience = 'Senior' and r_sum < 70000)
, remaining_money as(
select (70000 - sum(salary)) r from cte_senior)
, cte_junior as(
select * from cte where experience = 'Junior' and r_sum < (select r from remaining_money) )
select emp_id, experience, salary, sum(salary) over(order by salary) t
from(
select * from cte_junior
union all
select * from cte_senior) A