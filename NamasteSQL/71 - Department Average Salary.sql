with cte as(
select employees.*, departments.department_name 
from employees
inner join departments 
on employees.department_id  = departments.department_id)
select department_name,
round(avg(salary),2) average_salary
from cte
group by department_name
having count(*)>2
order by round(avg(salary),2) desc;