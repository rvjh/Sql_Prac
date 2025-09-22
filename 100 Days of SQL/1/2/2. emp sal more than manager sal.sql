select * from emp;

-- emp with sal more than their managers salary

with cte as(
select e1.emp_id, e1.emp_name emp_name, e1.salary emp_sal,
e2.manager_id, e2.emp_name manager_name, e2.salary manager_sal
from emp e1
inner join emp e2 on e1.manager_id = e2.emp_id)
select * from cte
where emp_sal > manager_sal;