select * from source;

select * from target;

with cte_source as(
select id, 
case when id not in (select id from target) then "New in Source" end c
from source)
, cte_target as(
select id, 
case when id not in (select id from source) then "New in Target" end c
from target)
, cte_comm as(
select source.id,
case when source.id = target.id and source.name != target.name then "Mismatch" end c
from source inner join target)
select * from(
select * from cte_source
union 
select * from cte_target
union 
select * from cte_comm) A 
where c is not null

