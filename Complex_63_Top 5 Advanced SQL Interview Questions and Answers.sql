-- top 3 products by sales, top 3 employees by salaries, within category/departent

select * from emp_v3;

-- top 2 highest paid employees 
select * from emp_v3 order by salary desc limit 2;
-- for each dept
with cte as(
select * ,
row_number() over(partition by department_id order by salary desc) rn, -- take this 
dense_rank() over(partition by department_id order by salary desc) rn_sense
from emp_v3 order by department_id, salary desc)
select * from cte;


