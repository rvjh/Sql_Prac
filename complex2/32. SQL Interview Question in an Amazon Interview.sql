select * from emp;

-- 3rd largest salary , incase less than 3 emp then return emp with lowest in that department 

with cte as(
select *,
row_number() over(partition by dep_name order by salary desc) rn,
count(1) over(partition by dep_id) cnt
from emp)
select emp_id, emp_name, dep_id , dep_name, salary
from cte
where rn=3 or (rn=cnt and cnt<3);