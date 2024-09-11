use test1;

create table family 
(
person varchar(5),
type varchar(10),
age int
);

insert into family values 
('A1','Adult',54),
('A2','Adult',53),('A3','Adult',52),('A4','Adult',58),('A5','Adult',54),('C1','Child',20),('C2','Child',19),('C3','Child',22),('C4','Child',15);

select * from family;

WITH cte_adult AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY person) AS rn
    FROM family
    WHERE type = 'Adult'
),
cte_child AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY person) AS rn
    FROM family
    WHERE type = 'Child'
)
SELECT cte_adult.person, cte_child.person
FROM cte_adult
LEFT JOIN cte_child
ON cte_adult.rn = cte_child.rn;


-- now the question is eldest with go with younger
select * from family;

WITH cte_adult AS
(
select *, row_number() over(order by age desc) as rm
from family where type="Adult"
),
cte_child AS
(
select *, row_number() over(order by age desc) as rm
from family where type="Child"
)
select cte_adult.person, cte_adult.age,cte_child.person,cte_child.age
FROM cte_adult
LEFT JOIN cte_child
ON cte_adult.rm = cte_child.rm
