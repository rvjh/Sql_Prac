create table event_status
(
event_time varchar(10),
status varchar(10)
);
insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');

select * from event_status;


with cte as(
select *,
sum(case when status='on' and prev_satus='off' then 1 else 0 end) over(order by event_time) grp_key
from (
select *,
lag(status, 1, status) over(order by event_time asc) prev_satus
from event_status) A)

select min(event_time) login, max(event_time) logout, count(1)-1 on_count
from cte
group by grp_key;
