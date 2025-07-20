select * from job_positions;
select * from job_employees;


select * from job_positions;
select * from job_employees;

with recursive cte as(
select id, title, grp, levels, payscale, totalpost, 1 as rn from job_positions
union all
select id, title, grp, levels, payscale, totalpost, rn+1  from cte
where rn+1 <= totalpost
),
cte3 as(
select *, 
row_number() over(partition by position_id order by id) c 
 from job_employees)
select cte.title,cte.grp, cte.levels, cte.payscale,
case when cte.rn = cte3.c then cte3.name else "vacant" end name
from cte left join cte3 on cte.id = cte3.position_id and cte.rn = cte3.c
order by grp;


select * from job_positions;
select * from job_employees;
 