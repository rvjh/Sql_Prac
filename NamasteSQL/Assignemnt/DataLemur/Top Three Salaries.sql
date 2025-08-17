with cte as(
SELECT name, department_id,salary,
dense_rank() over(PARTITION by department_id order by salary desc) rn
FROM employee) 
, cte2 as(
select cte.*, department.department_name
from cte 
inner join department on cte.department_id = department.department_id
where rn<=3)
select department_name, name, salary from cte2
order by department_name asc, salary desc, name asc;