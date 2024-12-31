use test1;

select * from icc_world_cup;

select team_name, count(1) as no_of_matches, sum(team_winner) No_of_matches_win,
(count(1) - sum(team_winner)) as No_of_match_Loss
from(
select team_1 as team_name,
case when team_1=winner then 1 else 0 end as team_winner
from icc_world_cup
union all
select team_2 as team_name,
case when team_2=winner then 1 else 0 end as team_winner
from icc_world_cup) A 
group by team_name
order by No_of_matches_win


