select * from airports_microsoft;
select * from flights_microsoft;


-- 

with flight_details as(
select flights_microsoft.*, a.city_name as start_city, b.city_name as end_city
from 
flights_microsoft 
inner join airports_microsoft a on flights_microsoft.start_port = a.port_code
inner join airports_microsoft b on flights_microsoft.end_port = b.port_code)
, direct_flight as(
select start_city, null as middle_city, end_city, flight_id, timestampdiff(minute, start_time, end_time) time_taken
from flight_details where start_city = "New York" and end_city="Tokyo")
, cte as(
select a.start_city, a.end_city as middle_city, b.end_city, 
concat(a.flight_id,',', b.flight_id) as flight_id,
timestampdiff(minute, a.start_time, b.end_time) time_taken
from 
(select * from flight_details
where start_city = "New York") a
inner join
(select * from flight_details
where end_city="Tokyo") b
on a.end_city = b.start_city and a.end_time <= b.start_time)
select * from direct_flight
union all
select * from cte;





