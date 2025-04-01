select * from employee_v1;

-- hignest and lowest salary of each dept

with cte as(
select dep_id,
min(salary) as min_sal, max(salary) max_sal
from employee_v1
group by dep_id)
, cte2 as(
select cte.dep_id, employee_v1.emp_name,employee_v1.salary, cte.min_sal, cte.max_sal
from cte inner join employee_v1 on cte.dep_id  = employee_v1.dep_id)
select dep_id,
max(case when salary = min_sal then emp_name end) as emp_name_min_sal,
max(case when salary = max_sal then emp_name end) as emp_name_max_sal
from cte2
group by dep_id
order by dep_id;


	with cte as(
	select *,
	row_number() over(partition by dep_id order by salary desc) rn_desc,
	row_number() over(partition by dep_id order by salary) rn_asc
	from employee_v1)
	select dep_id,
	max(case when rn_asc = 1 then emp_name end) as emp_name_min_sal,
	max(case when rn_desc = 1 then emp_name end) as emp_name_max_sal
	from cte
	group by dep_id;