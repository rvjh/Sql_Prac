select * from tasks;

SELECT *,
    ROW_NUMBER() OVER (PARTITION BY state ORDER BY date_value) AS rn,
    DATE_SUB(date_value, INTERVAL ROW_NUMBER() OVER (PARTITION BY state ORDER BY date_value) DAY) AS group_date
FROM tasks;

with all_dates as(
SELECT *,
    ROW_NUMBER() OVER (PARTITION BY state ORDER BY date_value) AS rn,
    DATE_SUB(date_value, INTERVAL ROW_NUMBER() OVER (PARTITION BY state ORDER BY date_value) DAY) AS group_date
FROM tasks)
select group_date, state, min(date_value) start_date, max(date_value) end_date
from all_dates
group by group_date, state
order by start_date
