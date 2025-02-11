select * from drivers;


-- total rides and profir rides of each driver
-- profit ride -> end loc of current ride is same as start loc of next ride
-- id total_rides profit rides

SELECT id,
COUNT(start_time) AS total_rides
FROM drivers
GROUP BY id;

select id, count(start_time) total_rides,
sum(case when end_loc = next_start_loc then 1 else 0 end) profit_rides
from(
SELECT *,
lead(start_loc,1) over(partition by id order by start_time asc) next_start_loc
FROM drivers) A
group by id;
