select client_id, month(time_id) month, count(distinct user_id) users_num
from fact_events
group by client_id, month
order by client_id