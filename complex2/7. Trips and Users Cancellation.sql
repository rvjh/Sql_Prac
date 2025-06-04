select * from trips_1;
select * from users_3;


select request_at,
count(case when status in ('cancelled_by_client','cancelled_by_driver') then 1 else null end) r,
count(1) total_trips,
(count(case when status in ('cancelled_by_client','cancelled_by_driver') then 1 else null end) / count(1))*100  cancellation_percentage
from trips_1 t 
inner join users_3 u on t.client_id = u.users_id
inner join users_3 s on t.driver_id = s.users_id
where u.banned="No" and s.banned="No"
group by request_at;