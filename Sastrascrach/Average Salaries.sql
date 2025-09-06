with cte as(
select department, avg(salary) avg_salary
from employee
group by department)
select c.department, e.first_name, e.salary, c.avg_salary
from employee e
inner join cte c on e.department = c.department
order by c.department