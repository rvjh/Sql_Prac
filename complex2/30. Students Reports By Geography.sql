select * from players_location;


select players_grp,
max(case when city='Bangalore' then name end) Bangalore
, max(case when city='Mumbai' then name end) Mumbai
, max(case when city='Delhi' then name end) Delhi
from (
select *, row_number() over(partition by city order by name asc) players_grp
 from players_location) A
 group by players_grp
 order by players_grp