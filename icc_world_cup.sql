create table icc_world_cup
(
match_no int,
team_1 Varchar(20),
team_2 Varchar(20),
winner Varchar(20)
);
INSERT INTO icc_world_cup values(1,'ENG','NZ','NZ');
INSERT INTO icc_world_cup values(2,'PAK','NED','PAK');
INSERT INTO icc_world_cup values(3,'AFG','BAN','BAN');
INSERT INTO icc_world_cup values(4,'SA','SL','SA');
INSERT INTO icc_world_cup values(5,'AUS','IND','IND');
INSERT INTO icc_world_cup values(6,'NZ','NED','NZ');
INSERT INTO icc_world_cup values(7,'ENG','BAN','ENG');
INSERT INTO icc_world_cup values(8,'SL','PAK','PAK');
INSERT INTO icc_world_cup values(9,'AFG','IND','IND');
INSERT INTO icc_world_cup values(10,'SA','AUS','SA');
INSERT INTO icc_world_cup values(11,'BAN','NZ','NZ');
INSERT INTO icc_world_cup values(12,'PAK','IND','IND');
INSERT INTO icc_world_cup values(12,'SA','IND','DRAW');

select * from icc_world_cup;

-- list of all the teams , played, won, loss, point

with cte as(
SELECT team, SUM(match_played) AS match_played
FROM (
    SELECT team_1 AS team, COUNT(*) AS match_played
    FROM icc_world_cup
    GROUP BY team_1
    UNION ALL
    SELECT team_2 AS team, COUNT(*) AS match_played
    FROM icc_world_cup
    GROUP BY team_2
) AS A
GROUP BY team
)
select cte.team, 
	   cte.match_played, 
       count(winner) as wins,
       (cte.match_played - count(winner)) as lost,
       (count(winner)*2) as points
from cte join icc_world_cup on cte.team = icc_world_cup.team_1
group by cte.team, cte.match_played
order by wins desc
