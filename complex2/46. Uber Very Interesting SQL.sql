select * from drivers;

-- total rides, profit rides



select id, count(1) total_rides 
from drivers
group by id;

select id, count(1) total_rides,
sum(case when end_loc = next_start_loc then 1 else 0 end) as profit_rides
from 
(select *  
, lead(start_loc, 1) over(partition by id order by start_time asc) next_start_loc
from drivers) A
group by id;



