use test1;

create table Ameriprise_LLC
(
teamID varchar(2),
memberID varchar(10),
Criteria1 varchar(1),
Criteria2 varchar(1)
);
insert into Ameriprise_LLC values 
('T1','T1_mbr1','Y','Y'),
('T1','T1_mbr2','Y','Y'),
('T1','T1_mbr3','Y','Y'),
('T1','T1_mbr4','Y','Y'),
('T1','T1_mbr5','Y','N'),
('T2','T2_mbr1','Y','Y'),
('T2','T2_mbr2','Y','N'),
('T2','T2_mbr3','N','Y'),
('T2','T2_mbr4','N','N'),
('T2','T2_mbr5','N','N'),
('T3','T3_mbr1','Y','Y'),
('T3','T3_mbr2','Y','Y'),
('T3','T3_mbr3','N','Y'),
('T3','T3_mbr4','N','Y'),
('T3','T3_mbr5','Y','N');

select * from Ameriprise_LLC;

select teamID, count(memberID) as no_of_eligible_members
from Ameriprise_LLC
where Criteria1='Y' and Criteria2='Y'
group by teamID
having count(memberID)>=2

WITH qualified_team AS (
    SELECT teamID, COUNT(memberID) AS no_of_eligible_members
    FROM Ameriprise_LLC
    WHERE Criteria1 = 'Y' AND Criteria2 = 'Y'
    GROUP BY teamID
    HAVING COUNT(memberID) >= 2
)
SELECT Ameriprise_LLC.*, 
       qualified_team.*,
       CASE 
           WHEN Ameriprise_LLC.Criteria1 = 'Y' 
                AND Ameriprise_LLC.Criteria2 = 'Y' 
                AND qualified_team.teamID IS NOT NULL 
           THEN 'Y'
           ELSE 'N'
       END AS qualified_flag
FROM Ameriprise_LLC
LEFT JOIN qualified_team 
ON Ameriprise_LLC.teamID = qualified_team.teamID;