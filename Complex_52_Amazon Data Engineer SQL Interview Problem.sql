select * from hall_events;

-- merge overlapping events in the same hall

WITH temp1 AS (
    SELECT *,
           LAG(end_date, 1, end_date) OVER (PARTITION BY hall_id ORDER BY start_date) AS lagDate
    FROM hall_events
),
temp2 AS (
    SELECT *,
           CASE 
               WHEN start_date = lagDate OR start_date < lagDate THEN 1
               ELSE 0
           END AS flag
    FROM temp1 
)
SELECT 
    hall_id,
    MIN(start_date) AS minDate,
    MAX(end_date) AS maxEnd
FROM 
    temp2 
GROUP BY 
    hall_id, flag;

