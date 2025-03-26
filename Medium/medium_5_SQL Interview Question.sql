select * from emp_salary;


select dept_id, salary
from emp_salary
group by dept_id, salary
having count(1)>1 ;


with cte as(
select dept_id, salary
from emp_salary
group by dept_id, salary
having count(1)>1)
select emp_salary.* from
emp_salary join cte on emp_salary.dept_id = cte.dept_id and emp_salary.salary = cte.salary
