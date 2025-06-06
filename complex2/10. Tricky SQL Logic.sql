select * from tasks;


with all_dates as(
select *,
row_number() over(partition by state order by date_value asc) rn,
DATE_SUB(date_value, INTERVAL ROW_NUMBER() OVER (PARTITION BY state ORDER BY date_value) DAY) AS group_date
from tasks
order by date_value asc)
select group_date, state, min(date_value) start_date, max(date_value) end_date
from all_dates
group by group_date, state
order by start_date;

