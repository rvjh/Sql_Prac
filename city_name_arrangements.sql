create table players_location
(
name varchar(20),
city varchar(20)
);

insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

select * from players_location;

-- format the table

select
(case when city='Mumbai' then name end) Mumbai
, (case when city='Bangalore' then name end) Bangalore
, (case when city='Delhi' then name end) Delhi
from players_location;


select grp_key
, max((case when city='Mumbai' then name end)) Mumbai
, max((case when city='Bangalore' then name end)) Bangalore
, max((case when city='Delhi' then name end)) Delhi
from
(select *,
row_number() over(partition by city order by name asc) grp_key
from players_location) A
group by grp_key
order by grp_key;


