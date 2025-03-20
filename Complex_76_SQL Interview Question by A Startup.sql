create table users_events 
(userid int , 
event_type varchar(20),
event_time datetime);

insert into users_events VALUES (1, 'click', '2023-09-10 09:00:00');
insert into users_events VALUES (1, 'click', '2023-09-10 10:00:00');
insert into users_events VALUES (1, 'scroll', '2023-09-10 10:20:00');
insert into users_events VALUES (1, 'click', '2023-09-10 10:50:00');
insert into users_events VALUES (1, 'scroll', '2023-09-10 11:40:00');
insert into users_events VALUES (1, 'click', '2023-09-10 12:40:00');
insert into users_events VALUES (1, 'scroll', '2023-09-10 12:50:00');
insert into users_events VALUES (2, 'click', '2023-09-10 09:00:00');
insert into users_events VALUES (2, 'scroll', '2023-09-10 09:20:00');
insert into users_events VALUES (2, 'click', '2023-09-10 10:30:00');

select * from users_events;


WITH cte AS (
    SELECT 
        *,
        LAG(event_time, 1, event_time) OVER (PARTITION BY userid ORDER BY event_time) AS prev_event,
        TIMESTAMPDIFF(MINUTE, 
                      LAG(event_time, 1, event_time) OVER (PARTITION BY userid ORDER BY event_time), 
                      event_time) AS time_diff
    FROM users_events
),
cte2 AS (
    SELECT *,
           CASE WHEN time_diff <= 30 THEN 0 ELSE 1 END AS flag,
           SUM(CASE WHEN time_diff <= 30 THEN 0 ELSE 1 END) 
               OVER (PARTITION BY userid ORDER BY event_time) AS session_num
    FROM cte
)
SELECT 
    userid,
    session_num+1 session_id,
    MIN(event_time) AS start_time,
    MAX(event_time) AS end_time,
    COUNT(*) AS no_of_events,
    TIMESTAMPDIFF(MINUTE, MIN(event_time), MAX(event_time)) AS session_duration
FROM cte2
GROUP BY userid, session_num
order by userid, session_num;

