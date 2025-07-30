create table events7
(userid int , 
event_type varchar(20),
event_time datetime);

insert into events7 VALUES (1, 'click', '2023-09-10 09:00:00');
insert into events7 VALUES (1, 'click', '2023-09-10 10:00:00');
insert into events7 VALUES (1, 'scroll', '2023-09-10 10:20:00');
insert into events7 VALUES (1, 'click', '2023-09-10 10:50:00');
insert into events7 VALUES (1, 'scroll', '2023-09-10 11:40:00');
insert into events7 VALUES (1, 'click', '2023-09-10 12:40:00');
insert into events7 VALUES (1, 'scroll', '2023-09-10 12:50:00');
insert into events7 VALUES (2, 'click', '2023-09-10 09:00:00');
insert into events7 VALUES (2, 'scroll', '2023-09-10 09:20:00');
insert into events7 VALUES (2, 'click', '2023-09-10 10:30:00');


select * from events7;


WITH cte AS (
  SELECT *,
         LAG(event_time, 1, event_time) OVER (PARTITION BY userid ORDER BY event_time) AS prev_event_time,
         TIMESTAMPDIFF(MINUTE, LAG(event_time, 1, event_time) OVER (PARTITION BY userid ORDER BY event_time), event_time) AS time_diff
  FROM events7
),
cte2 AS (
  SELECT *,
         CASE WHEN time_diff <= 30 THEN 0 ELSE 1 END AS f,
         SUM(CASE WHEN time_diff <= 30 THEN 0 ELSE 1 END) OVER (PARTITION BY userid ORDER BY event_time) AS session_id
  FROM cte
)
SELECT 
  userid,
  session_id + 1 AS session_grp,
  MIN(event_time) AS session_start_time,
  MAX(event_time) AS session_end_time, -- 👈 changed from prev_event_time
  COUNT(*) AS event_cnt,
  TIMESTAMPDIFF(MINUTE, MIN(event_time), MAX(event_time)) AS time_diff
FROM cte2
GROUP BY userid, session_id + 1
ORDER BY userid, session_id + 1;


