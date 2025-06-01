select * from entries;

with visit_floor as(
select name, floor, count(1) as total_visit,
rank() over(partition by name order by count(1) desc) rn
from entries
group by name, floor)
, cte1 as(
select name, floor most_visited_floor 
from visit_floor where rn=1)
, cte2 as(
select name, group_concat(distinct resources) resource_dev from entries
group by name)
select cte1.name, sum(visit_floor.total_visit) total_visit, cte1.most_visited_floor, cte2.resource_dev
from visit_floor 
inner join cte1 on visit_floor.name = cte1.name
inner join cte2 on visit_floor.name = cte2.name
group by cte1.name,cte1.most_visited_floor, cte2.resource_dev;

 