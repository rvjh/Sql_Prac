use test1;

CREATE TABLE emp_salary(
    emp_id INTEGER  NOT NULL,
    name VARCHAR(20)  NOT NULL,
    salary VARCHAR(30),
    dept_id INTEGER
);


INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');

select * from emp_salary;

-- Salary is same in same department

select * from emp_salary
order by dept_id;


SELECT dept_id, salary
FROM emp_salary
GROUP BY dept_id, salary
HAVING COUNT(*) > 1;

select emp_salary.* from emp_salary
inner join
(SELECT dept_id, salary
FROM emp_salary
GROUP BY dept_id, salary
HAVING COUNT(*) > 1) as m
on emp_salary.dept_id = m.dept_id
order by emp_salary.salary





