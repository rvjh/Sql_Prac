-- Data Analyst Spotify Case Study

select * from activity;

-- 1. total # of active users each day
-- event_date active_users

select event_date, count(distinct user_id) from activity where event_name='app-purchase'
group by event_date;

-- 2. total active users each week
-- week_num active_user

SELECT 
    WEEK(event_date) AS week_number,
    COUNT(DISTINCT user_id) AS user_count
FROM 
    activity 
WHERE 
    event_name = 'app-purchase'
GROUP BY 
    WEEK(event_date);

-- 3. datewise total # of users who puechase the same date they installed the app

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

-- 4. percentage of paid users in ind, usa, and other countries tagges others

select * from activity;


select country, count(user_id) from activity
where event_name='app-purchase'
group by country;


select count(distinct user_id),
case when country in ('India','USA') then country else 'Others' end Country
from activity
where event_name='app-purchase'
group by (case when country in ('India','USA') then country else 'Others' end);

SELECT 
    (usr_cnt / SUM(usr_cnt) OVER ())*100 AS percentage, 
    Country 
FROM (
    SELECT 
        COUNT(DISTINCT user_id) AS usr_cnt,
        CASE 
            WHEN country IN ('India', 'USA') THEN country 
            ELSE 'Others' 
        END AS Country
    FROM activity
    WHERE event_name = 'app-purchase'
    GROUP BY 
        CASE 
            WHEN country IN ('India', 'USA') THEN country 
            ELSE 'Others' 
        END
) A
GROUP BY Country, usr_cnt;

-- 5. users who have installed the app on a given date, how many purchased on the very next day 
-- day wise result

select * ,
lag(event_name,1) over(partition by user_id order by event_date) perv_event_name,
lag(event_date,1) over(partition by user_id order by event_date) perv_event_date
from activity;

WITH prev_data AS (
    SELECT *,
        LAG(event_name, 1) OVER (PARTITION BY user_id ORDER BY event_date) AS perv_event_name,
        LAG(event_date, 1) OVER (PARTITION BY user_id ORDER BY event_date) AS perv_event_date
    FROM activity
)
SELECT event_date, count(distinct user_id) usr_cnt
FROM prev_data 
WHERE event_name = 'app-purchase' 
    AND perv_event_name = 'app-installed' 
    AND DATEDIFF(event_date, perv_event_date) = 1
group by event_date
