select * from events;

-- swimmers wo won only gold and how many gold

select gold, count(*) no_of_medals
from events where GOLD not in(
select SILVER from events
union all
select BRONZE from events)
group by gold;

--- 

with cte as(
select gold as player_name, 'gold' medal_type from events
union all
select silver as player_name, 'silver' medal_type from events
union all
select bronze as player_name, 'bronze' medal_type from events)
select  player_name, count(1) as no_of_gold
from cte
group by player_name
having count(distinct medal_type) = 1 and max(medal_type)='gold';


