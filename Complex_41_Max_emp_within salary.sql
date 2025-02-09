select * from candidates;

-- max employees 

select *, sum(salary) over(partition by experience order by salary asc) rsum
from candidates;


with toal_sal as(
select *, 
sum(salary) over(partition by experience order by salary asc rows between unbounded preceding and current row) rsum
from candidates),
senior as(
select * from toal_sal
where experience = 'Senior' and rsum<=70000),
junior as(
select * from toal_sal
where experience = 'Junior' and rsum<=70000 - (select sum(salary) from senior))
select * from junior
union all
select * from senior