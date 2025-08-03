-- select * from employees;
-- select * from projects;
-- select * from project_employees;

WITH cte AS (
SELECT id, title, budget,
TIMESTAMPDIFF(MONTH, start_date, end_date) AS duration
FROM projects)
, cte2 as(
SELECT cte.*, project_employees.employee_id  
FROM cte
INNER JOIN project_employees 
ON cte.id = project_employees.project_id)
, cte3 as(
select cte2.*,employees.name, employees.salary
from cte2
inner join employees on cte2.employee_id = employees.id)
, cte4 as(
select title, budget, duration, sum(salary) agg_sal
from cte3
group by title, budget, duration)
select title,budget,
case when agg_sal/duration > budget then 'overbudget'
	 else 'within budget'
     end as label
from cte4
order by title
