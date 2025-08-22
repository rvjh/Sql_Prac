
with cte as(
SELECT u1.user_id, u1.event_type last_event_type, u1.event_date last_event_date,
u2.event_type prev_event_type,u2.event_date prev_event_date
FROM user_actions u1
join user_actions u2 
on u1.user_id = u2.user_id 
and EXTRACT(month from u1.event_date) -1 = EXTRACT(month from u2.event_date)
), cte2 as(
select * 
from cte 
where EXTRACT(month from last_event_date) = 7 
and EXTRACT(year from prev_event_date)=2022)
select EXTRACT(month from last_event_date) as month,
count(DISTINCT user_id) monthly_active_users
from cte2
GROUP by EXTRACT(month from last_event_date);