select * from job_positions;
select * from job_employees;

-- title group level payscale emp_name

with recursive cte as(
select id, title, grp, levels, payscale, totalpost, 1 as rn from job_positions
union all
select id, title, grp, levels, payscale, totalpost, rn+1 from cte
where rn+1<=totalpost
)
, emp as(
select *,
row_number() over(partition by position_id order by id) rn
from job_employees
)
select cte.*,
case when emp.name is null then 'Vacant' else emp.name end emp_name 
from cte 
left join emp on cte.id = emp.position_id and cte.rn = emp.rn
order by cte.id

