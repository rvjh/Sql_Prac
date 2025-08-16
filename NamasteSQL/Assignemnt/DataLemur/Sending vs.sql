with cte as(
SELECT user_id, 
sum(case when activity_type='send' then time_spent else 0 end) t_sending,
sum(case when activity_type='open' then time_spent else 0 end) t_opening
FROM activities
GROUP by user_id)
, cte2 as(
select cte.*, age_breakdown.age_bucket 
from cte
inner join age_breakdown on cte.user_id = age_breakdown.user_id)
select  age_bucket,
round(t_sending/(t_sending + t_opening)*100.0,2) send_perc,
round(t_opening/(t_sending + t_opening)*100.0,2) open_perc
from cte2
order by age_bucket asc;