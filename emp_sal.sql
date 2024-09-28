CREATE TABLE emp_v2 (
    emp_id INT,
    emp_name VARCHAR(20),
    department_id INT,
    salary INT,
    manager_id INT,
    emp_age INT
);

INSERT INTO emp_v2 (emp_id, emp_name, department_id, salary, manager_id, emp_age) VALUES
(1, 'Ankit', 100, 10000, 4, 39),
(2, 'Mohit', 100, 15000, 5, 48),
(3, 'Vikas', 100, 12000, 4, 37),
(4, 'Rohit', 100, 14000, 2, 16),
(5, 'Mudit', 200, 20000, 6, 55),
(6, 'Agam', 200, 12000, 2, 14),
(7, 'Sanjay', 200, 9000, 2, 13),
(8, 'Ashish', 200, 5000, 2, 12),
(9, 'Mukesh', 300, 6000, 6, 51),
(10, 'Rakesh', 500, 7000, 6, 50);

select * from emp_v2;

-- emp name with their managers name ans sm name
-- sm is manager of manager


select e1.emp_id, e1.emp_name, e1.salary as emp_sal, 
	   e2.emp_name as Manager, e2.salary as Mng_Sal, 
	   e3.emp_name as Senior_Mngr, e3.salary as Senior_Mngr_sal
from emp_v2 e1 
left join emp_v2 e2 on e1.manager_id = e2.emp_id
left join emp_v2 e3 on e2.manager_id = e3.emp_id




