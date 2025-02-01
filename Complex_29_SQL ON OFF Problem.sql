select * from event_status;

-- return logon logoff how_many_times_on

select *,
lag(status,1,status) over(order by event_time asc) perv_evnt
from event_status;

select *,
sum(case when status='on' and perv_evnt='off' then 1 else 0 end) over(order by event_time) grp_key
from(
select *,
lag(status,1,status) over(order by event_time asc) perv_evnt
from event_status) A;


with cte as(
select *,
sum(case when status='on' and perv_evnt='off' then 1 else 0 end) over(order by event_time) grp_key
from(
select *,
lag(status,1,status) over(order by event_time asc) perv_evnt
from event_status) A)
select min(event_time) login, 
max(event_time) logout,
count(1) -1 on_cnt
 from cte group by grp_key