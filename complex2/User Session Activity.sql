WITH cte AS (
  SELECT *, 
         LAG(event_time, 1, event_time) OVER (PARTITION BY userid ORDER BY event_time) AS prev_event_time
  FROM events
),
cte2 AS (
  SELECT *, 
         TIMESTAMPDIFF(MINUTE, prev_event_time, event_time) AS session_duration
  FROM cte
),
cte3 AS (
  SELECT *, 
         CASE WHEN session_duration > 30 THEN 1 ELSE 0 END AS session_flag,
         SUM(CASE WHEN session_duration > 30 THEN 1 ELSE 0 END) OVER (PARTITION BY userid ORDER BY event_time) AS session_id
  FROM cte2
)
SELECT 
  userid,
  session_id,
  MIN(event_time) AS session_start_time,
  MAX(event_time) AS session_end_time,
  TIMESTAMPDIFF(MINUTE, MIN(event_time), MAX(event_time)) AS session_duration,
  COUNT(*) AS event_count
FROM cte3
GROUP BY userid, session_id
ORDER BY userid, session_id;