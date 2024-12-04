create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');

select * from hospital;

-- find total number of employees present in hospital

select *,
case when action='in' then time end as in_time,
case when action='out' then time end as out_time
from hospital;

-- with case

with cte as(
select emp_id,
max(case when action='in' then time end) in_time,
max(case when action='out' then time end) out_time
from hospital
group by emp_id)
select * from cte
where out_time < in_time or out_time is null;

-- with having

select emp_id,
max(case when action='in' then time end) in_time,
max(case when action='out' then time end) out_time
from hospital
group by emp_id
having max(case when action='in' then time end) > max(case when action='out' then time end)
or max(case when action='out' then time end) is null;
