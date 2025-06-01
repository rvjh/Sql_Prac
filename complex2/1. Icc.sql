use test1;

select * from icc_world_cup;

with cte as(
select Team_1 as team, case when team_1 = winner then 1 else 0 end winner
from icc_world_cup
union all
select Team_2 as team, case when team_2 = winner then 1 else 0 end winner
from icc_world_cup)
select team, count(*) no_of_matches_played, sum(winner) no_of_wins, 
(count(*) - sum(winner)) no_of_loss
from cte
group by team;




