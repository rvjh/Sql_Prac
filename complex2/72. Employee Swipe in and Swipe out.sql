select * from swipe;


-- 1. find time emp spent in a office for a particular day
-- 2. many swips , find actual time spent on office

with cte as(
select employee_id,
date(activity_time) d, min(activity_time) login_time, max(activity_time) logout_time
from swipe
group by employee_id, date(activity_time))
select *, timestampdiff(hour,login_time, logout_time) office_hour
from cte;


-- 

with cte as(
select *, date(activity_time) activity_day,
lead(activity_time,1) over(partition by employee_id,date(activity_time) order by date(activity_time)) logout_time
from swipe)
, cte2 as(
select *,
timestampdiff(hour,activity_time, logout_time) t
from cte)
, cte3 as(
select employee_id, activity_day
, sum(case when activity_type = 'login' then t else 0 end) total_login,
sum(case when activity_type = 'logout' then t else 0 end) total_logout
from cte2 
group by employee_id, activity_day)
select *, (total_login - total_logout) time_spent_in_office
from cte3


