select * from icc_world_cup;

-- team name, match played, no of wins, no of loss

with cte as(
select team_1 as team_name, 
case when team_1 = winner then 1 else 0 end win_flag
from icc_world_cup
union all
select team_2 as team_name ,
case when team_2 = winner then 1 else 0 end win_flag
from icc_world_cup)
select team_name, count(*) total_match, sum(win_flag) no_of_wins, 
count(*)- sum(win_flag) no_of_loss
from cte
group by team_name;
