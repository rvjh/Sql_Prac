CREATE TABLE city_distance
(
    distance INT,
    source VARCHAR(512),
    destination VARCHAR(512)
);


INSERT INTO city_distance(distance, source, destination) VALUES ('100', 'New Delhi', 'Panipat');
INSERT INTO city_distance(distance, source, destination) VALUES ('200', 'Ambala', 'New Delhi');
INSERT INTO city_distance(distance, source, destination) VALUES ('150', 'Bangalore', 'Mysore');
INSERT INTO city_distance(distance, source, destination) VALUES ('150', 'Mysore', 'Bangalore');
INSERT INTO city_distance(distance, source, destination) VALUES ('250', 'Mumbai', 'Pune');
INSERT INTO city_distance(distance, source, destination) VALUES ('250', 'Pune', 'Mumbai');
INSERT INTO city_distance(distance, source, destination) VALUES ('2500', 'Chennai', 'Bhopal');
INSERT INTO city_distance(distance, source, destination) VALUES ('2500', 'Bhopal', 'Chennai');
INSERT INTO city_distance(distance, source, destination) VALUES ('60', 'Tirupati', 'Tirumala');
INSERT INTO city_distance(distance, source, destination) VALUES ('80', 'Tirumala', 'Tirupati');


select * from city_distance;
-- remove duplicates and print only first values

select c1.*, c2.* from 
city_distance c1 left join city_distance c2 
on c1.source = c2.destination and c1.destination = c2.source;


select c1.*, c2.* from 
city_distance c1 left join city_distance c2 
on c1.source = c2.destination and c1.destination = c2.source
where c2.distance is null or c1.distance != c2.distance;

-- now taking ascii value 

select c1.* from 
city_distance c1 left join city_distance c2 
on c1.source = c2.destination and c1.destination = c2.source
where c2.distance is null or c1.distance != c2.distance or c1.source < c1.destination;


-- 

with cte as(
select * ,
case when source < destination then source else destination end city1,
case when source < destination then destination else source end city2
from city_distance)
, cte2 as(
select *,
count(*) over(partition by city1, city2, distance) cnt
from cte)
select distance, source, destination from cte2
where cnt=1 or (source < destination)
 