select * from event_status;


with cte as(
select * 
, lag(status,1,status) over(order by event_time) prev_status
from event_status)
, cte2 as(
select *
, sum(case when status = 'on' and prev_status='off' then 1 else 0 end) over(order by event_time) rn
from cte)
select min(event_time) start_time, max(event_time) end_time, count(1) -1 cnt
from cte2
group by rn