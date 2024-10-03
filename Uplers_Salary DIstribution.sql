
Create table candidates_v2(
id int primary key,
positions varchar(10) not null,
salary int not null);

insert into candidates_v2 values(1,'junior',5000);
insert into candidates_v2 values(2,'junior',7000);
insert into candidates_v2 values(3,'junior',7000);
insert into candidates_v2 values(4,'senior',10000);
insert into candidates_v2 values(5,'senior',30000);
insert into candidates_v2 values(6,'senior',20000);

select * from candidates_v2;

-- total budget 50K 1st pref is senior then junior
-- case 1

with running_cte as(
select * 
, sum(salary) over(partition by positions order by salary asc, id) running_sal
from candidates_v2
), 
seniors_cte as(
select count(*) as seniors, sum(salary) s_sal from running_cte where positions='senior' and running_sal < 50000
), 
juniors_cte as(
select count(*) juniors from running_cte 
	where positions='junior' and running_sal <= 50000 - (select s_sal from seniors_cte))
select seniors,  juniors from juniors_cte, seniors_cte;
