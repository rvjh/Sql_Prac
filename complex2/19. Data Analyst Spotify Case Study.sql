select * from activity;

-- find total active users per date

select event_date, count(distinct user_id) active_users from activity
group by event_date;

-- total active users each week
-- weeknum active_users

select week(event_date)+1 week_num, count(distinct user_id) active_users from activity
group by week(event_date)+1;

-- datewise total number of users where install day = purchase day

select A.event_date, count(B.user_id) total_users from
(select * from activity where event_name = "app-installed") A
inner join
(select * from activity where event_name = "app-purchase") B
on A.user_id = B.user_id and A.event_date = B.event_date
group by A.event_date;


select user_id, event_date, count(distinct event_name) no_of_events
from activity
group by user_id, event_date having count(distinct event_name)=2;

select event_date, count(user_id) no_of_users from(
select user_id, event_date, count(distinct event_name) no_of_events
from activity
group by user_id, event_date having count(distinct event_name)=2) A
group by event_date;


select event_date, count(new_user) no_of_users from(
select user_id, event_date, 
case when count(distinct event_name)=2 then user_id else null end new_user
-- count(distinct event_name) no_of_events
from activity
group by user_id, event_date) A
group by event_date;

-- percentage of paid users(purchase)


with cte as(
select case when country in ("India","USA") then country else "Others" end new_country, 
count(distinct user_id) c
from activity where event_name = "app-purchase"
group by (case when country in ("India","USA") then country else "Others" end))
select new_country, c/(select sum(c) from cte) p from cte;


-- install and very next day purchase

select * from activity;

WITH cte AS (
    SELECT *,
           LAG(event_name) OVER (PARTITION BY user_id ORDER BY event_date) AS prev_event_name,
           LAG(event_date) OVER (PARTITION BY user_id ORDER BY event_date) AS prev_event_date
    FROM activity
)
SELECT event_date, count(distinct user_id) u
FROM cte
WHERE event_name = 'app-purchase'
      AND prev_event_name = 'app-installed'
      AND DATEDIFF(event_date, prev_event_date) = 1
group by event_date;


WITH cte AS (
    SELECT *,
           LAG(event_name) OVER (PARTITION BY user_id ORDER BY event_date) AS prev_event_name,
           LAG(event_date) OVER (PARTITION BY user_id ORDER BY event_date) AS prev_event_date
    FROM activity
)
SELECT event_date,
sum(case when event_name = 'app-purchase' AND prev_event_name = 'app-installed' AND DATEDIFF(event_date, prev_event_date) = 1 then 1 else 0 end) u
from cte
group by event_date;


