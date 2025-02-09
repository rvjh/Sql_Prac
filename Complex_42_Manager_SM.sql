-- emp name along with their managers and senior managers(managers manager) name

--  manager table 

select e1.emp_id, e1.emp_name, e2.emp_name Manager, e2.emp_id Man_id 
from emp_v2 e1 left join emp_v2 e2 on e1.manager_id = e2.emp_id;

-- sm table

select e1.emp_id, e1.emp_name, e2.emp_name Manager, e2.emp_id Man_id, sm.emp_name SM_name, sm.emp_id SM_id
from emp_v2 e1 
left join emp_v2 e2 on e1.manager_id = e2.emp_id
left join emp_v2 sm on e2.manager_id = sm.emp_id


