select * from call_start_logs;
select * from call_end_logs;

select call_start_logs.phone_number, call_start_logs.start_time,call_end_logs.end_time from 
call_start_logs inner join call_end_logs 
on call_start_logs.phone_number = call_end_logs.phone_number
and call_start_logs.start_time < call_end_logs.end_time;


WITH cte1 AS (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY start_time) AS rn1
FROM call_start_logs
),
cte2 AS (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY end_time) AS rn2
FROM call_end_logs
)
SELECT cte1.phone_number,
cte1.start_time, cte2.end_time, timediff(cte2.end_time, cte1.start_time) time_diff_min
FROM cte1 JOIN cte2
ON cte1.phone_number = cte2.phone_number AND cte1.rn1 = cte2.rn2;

