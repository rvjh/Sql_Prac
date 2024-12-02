use test1;

select * from events;

-- find the #  of shwimers who won godl medals

-- subquery
select gold as player_name, count(1) as no_of_medals
from events 
where gold not in (select silver from events union all select bronze from events)
group by gold;

-- having groupby
with cte as(
select gold as player_name, 'gold' as medal_type from events
union all
select silver, 'silver' as medal_type from events
union all
select bronze, 'bronze' as medal_type from events
)
select player_name, count(*) from cte
group by player_name
having count(distinct medal_type)=1 and max(medal_type)='gold'