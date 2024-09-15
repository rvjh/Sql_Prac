create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

-- output -> team - wins- loss

select M.team_1 as team, count(1) as no_of_matches_played, sum(M.win_flag) as matches_own, count(1)-sum(M.win_flag) as match_lost
from
(
select team_1
, case when team_1 = winner then 1 else 0 end as win_flag
from icc_world_cup 
union all
select team_2
, case when team_2 = winner then 1 else 0 end as win_flag
from icc_world_cup
) M
group by M.team_1
order by no_of_matches_played desc;
