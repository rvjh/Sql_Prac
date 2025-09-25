select * from entries;


-- name, total visit, most visited floor, resources_accessed

select * from entries;

with cte as(
select name, floor,  count(*) no_of_floor_visit, resources
from entries
group by name, floor,resources)
, cte2 as(
select * 
, rank() over(partition by floor order by no_of_floor_visit desc) rn
from cte)
select name, sum(floor) as total_visit,
max(case when rn=1 then floor end) as most_visited_floor,group_concat(resources) resources_accessed
from cte2
group by name;