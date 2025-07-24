select * from city_distance;


-- remove duplicate and take only first record

-- with cte as(
-- select *, 
-- dense_rank() over(partition by distance order by source,destination) rn
-- from city_distance)
-- select * from cte where rn=1


select c1.* from 
city_distance c1 
left join city_distance c2 
on c1.destination = c2.source and c1.source = c2.destination
where c2.distance is null or c1.distance != c2.distance or c1.source < c1.destination;

with cte as(
select *,
case when source < destination then source else destination end city_1,
case when source < destination then destination else source end city_2
from city_distance)
, cte2 as(
select *,
count(*) over(partition by city_1, city_2, distance) rn
from cte)
select distance, source , destination from cte2
where rn=1 or (source < destination);

