create table candidates (
emp_id int,
experience varchar(20),
salary int
);

insert into candidates values
(1,'Junior',10000),(2,'Junior',15000),(3,'Junior',40000),(4,'Senior',16000),(5,'Senior',20000),(6,'Senior',50000);

select * from candidates;

-- company budget is $70000
-- hiering new employees -> keep hiring seniors with smallest salary untill you cannot hier anymore
-- keep the remaining salary to hire juniors
-- sql for hire junior senior

select * from candidates;

-- running sum

with cte as(
select *, 
sum(salary) over(partition by experience order by salary asc rows between unbounded preceding and current row) running_sal
from candidates
), seniors as(
select * from cte
where experience='Senior' and running_sal<=70000)

select * from cte
where experience='Junior' and running_sal<=70000 - (select sum(salary) from seniors)
union all
select * from seniors
