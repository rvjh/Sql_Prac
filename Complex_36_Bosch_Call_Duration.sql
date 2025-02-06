select * from call_details;

-- write sql for the below cond: 
-- 1. numbers have both incoming and outgoing calls
-- 2. sum of duration of outgoing > sum of duration of incoming


-- 1. 

select call_number,
sum(case when call_type='OUT' then call_duration else null end) out_duration,
sum(case when call_type='INC' then call_duration else null end) in_duration
from call_details
group by call_number;

with cte as(
select call_number,
sum(case when call_type='OUT' then call_duration else null end) out_duration,
sum(case when call_type='INC' then call_duration else null end) in_duration
from call_details
group by call_number)
select * from cte where out_duration > in_duration;

-- using having clause

SELECT call_number,
    SUM(CASE WHEN call_type = 'OUT' THEN call_duration ELSE NULL END) AS out_duration,
    SUM(CASE WHEN call_type = 'INC' THEN call_duration ELSE NULL END) AS in_duration
FROM call_details
GROUP BY call_number
HAVING out_duration > in_duration;

-- using cte and join

with cte_out as(
SELECT call_number,
SUM(call_duration) AS out_duration
FROM call_details
where call_type = "OUT"
GROUP BY call_number),
cte_in as(
SELECT call_number,
SUM(call_duration) AS in_duration
FROM call_details
where call_type = "INC"
GROUP BY call_number)
select cte_out.call_number,
cte_out.out_duration, cte_in.in_duration
from cte_out join cte_in on cte_out.call_number = cte_in.call_number
where cte_out.out_duration > cte_in.in_duration







