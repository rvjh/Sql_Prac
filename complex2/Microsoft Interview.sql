CREATE TABLE airports_microsoft (
    port_code VARCHAR(10) PRIMARY KEY,
    city_name VARCHAR(100)
);

CREATE TABLE flights_microsoft (
    flight_id varchar (10),
    start_port VARCHAR(10),
    end_port VARCHAR(10),
    start_time datetime,
    end_time datetime
);

INSERT INTO airports_microsoft (port_code, city_name) VALUES
('JFK', 'New York'),
('LGA', 'New York'),
('EWR', 'New York'),
('LAX', 'Los Angeles'),
('ORD', 'Chicago'),
('SFO', 'San Francisco'),
('HND', 'Tokyo'),
('NRT', 'Tokyo'),
('KIX', 'Osaka');

INSERT INTO flights_microsoft VALUES
(1, 'JFK', 'HND', '2025-06-15 06:00', '2025-06-15 18:00'),
(2, 'JFK', 'LAX', '2025-06-15 07:00', '2025-06-15 10:00'),
(3, 'LAX', 'NRT', '2025-06-15 10:00', '2025-06-15 22:00'),
(4, 'JFK', 'LAX', '2025-06-15 08:00', '2025-06-15 11:00'),
(5, 'LAX', 'KIX', '2025-06-15 11:30', '2025-06-15 22:00'),
(6, 'LGA', 'ORD', '2025-06-15 09:00', '2025-06-15 12:00'),
(7, 'ORD', 'HND', '2025-06-15 11:30', '2025-06-15 23:30'),
(8, 'EWR', 'SFO', '2025-06-15 09:00', '2025-06-15 12:00'),
(9, 'LAX', 'HND', '2025-06-15 13:00', '2025-06-15 23:00'),
(10, 'KIX', 'NRT', '2025-06-15 08:00', '2025-06-15 10:00');



select * from airports_microsoft;
select * from flights_microsoft;

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
select * from cte

