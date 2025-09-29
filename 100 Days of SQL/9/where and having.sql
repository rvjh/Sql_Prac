select * from emp;

select dep_id, avg(salary) avg_sal
from emp
group by dep_id
having avg(salary) > 10000;


select dep_id, avg(salary)
from
(
select *
from emp
where salary > 10000) A
group by dep_id
having avg(salary) > 10000;