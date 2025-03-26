select * from hospital;

select emp_id,
max(case when action = 'in' then time end) as in_time,
max(case when action = 'out' then time end) as out_time
from hospital
group by emp_id
having in_time > out_time or out_time is null;

-- --------------

with intime as(
select emp_id, max(time) latest_intime 
from hospital
where action='in'
group by emp_id),
outime as(
select emp_id, max(time) latest_outime 
from hospital
where action='out'
group by emp_id)
select * from intime left join outime on intime.emp_id = outime.emp_id
where latest_intime > latest_outime or latest_outime is null;
