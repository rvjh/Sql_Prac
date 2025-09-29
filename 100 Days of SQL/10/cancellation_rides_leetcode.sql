select * from trips_1;
select * from users;

with cte as(
select request_at, 
count(case when status in ('cancelled_by_client','cancelled_by_driver') then 1 else null end) cnt,
count(1) total_rides
from trips_1 
inner join users u1 on trips_1.client_id = u1.users_id
inner join users u2 on trips_1.driver_id = u2.users_id
where u1.banned = 'No' and u2.banned = 'No'
group by request_at
)
select request_at, cnt/total_rides cancellation_percentage
from cte
