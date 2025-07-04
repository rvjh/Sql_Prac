select * from emp;

-- get emp, managers and seniors mg name


select e.emp_id, e.emp_name, m.emp_id as manager_id, m.emp_name manager_name, sm.emp_id sm_id, sm.emp_name sm_name
from emp e
left join emp m on e.manager_id = m.emp_id
left join emp sm on m.manager_id = sm.emp_id;





