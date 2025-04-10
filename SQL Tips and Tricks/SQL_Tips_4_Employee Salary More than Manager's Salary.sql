select * from emp_v3;

with cte as(
select e1.emp_id, e1.emp_name, e1.department_id, e1.salary, e2.manager_id, e2.emp_name manager_name, e2.department_id dept, e2.salary man_sal
from emp_v3 e1 join emp_v3 e2 on e1.manager_id = e2.emp_id)
select * from cte
where department_id = dept and salary>man_sal