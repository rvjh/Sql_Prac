select distinct user_id
from
(select
user_id,record_date, lag(record_date,1) over(partition by user_id order by record_date),
datediff(record_date, lag(record_date,1) over(partition by user_id order by record_date)) a,
datediff(record_date, lead(record_date,1) over(partition by user_id order by record_date)) b
from sf_events) a 
where a = 1 and b=-1