select * from emp;

with cte as(
select dep_id, avg(salary) dep_avg, count(*) no_of_emp, sum(salary) dep_total_sal
from emp
group by dep_id)
, cte2 as(
select e1.dep_id e1_dep, e1.dep_avg, e2.dep_id e2_dep, e2.no_of_emp, e2.dep_total_sal
from
cte e1 inner join cte e2 on e1.dep_id != e2.dep_id 
order by e1.dep_id asc)
select e1_dep, sum(dep_total_sal)/sum(no_of_emp) as company_avg_with_same_dep
from cte2
group by e1_dep
order by e1_dep asc

