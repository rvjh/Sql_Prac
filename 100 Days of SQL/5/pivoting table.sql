select * from emp_compensation;


-- pivoting 

select emp_id,
max(case when salary_component_type = 'salary' then val end) salary,
max(case when salary_component_type = 'bonus' then val end) bonus,
max(case when salary_component_type = 'hike_percent' then val end) hike_percent
from emp_compensation
group by emp_id;
