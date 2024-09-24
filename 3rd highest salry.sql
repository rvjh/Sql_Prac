CREATE TABLE emp (
    emp_id INT NULL,
    emp_name VARCHAR(50) NULL,
    salary INT NULL,
    manager_id INT NULL,
    emp_age INT NULL,
    dep_id INT NULL,
    dep_name VARCHAR(20) NULL,
    gender VARCHAR(10) NULL
);

INSERT INTO emp (emp_id, emp_name, salary, manager_id, emp_age, dep_id, dep_name, gender) VALUES
(1, 'Ankit', 14300, 4, 39, 100, 'Analytics', 'Female'),
(2, 'Mohit', 14000, 5, 48, 200, 'IT', 'Male'),
(3, 'Vikas', 12100, 4, 37, 100, 'Analytics', 'Female'),
(4, 'Rohit', 7260, 2, 16, 100, 'Analytics', 'Female'),
(5, 'Mudit', 15000, 6, 55, 200, 'IT', 'Male'),
(6, 'Agam', 15600, 2, 14, 200, 'IT', 'Male'),
(7, 'Sanjay', 12000, 2, 13, 200, 'IT', 'Male'),
(8, 'Ashish', 7200, 2, 12, 200, 'IT', 'Male'),
(9, 'Mukesh', 7000, 6, 51, 300, 'HR', 'Male'),
(10, 'Rakesh', 8000, 6, 50, 300, 'HR', 'Male'),
(11, 'Akhil', 4000, 1, 31, 500, 'Ops', 'Male');

select * from emp;

-- 3rd highest salry in case less than 3 employees in a depy then retuen with
-- lowest salary in that department


with cte as(
select emp_id, emp_name, salary,emp_age, dep_name, gender 
, rank() over(partition by dep_name order by salary desc) S
, count(1) over(partition by dep_id) cnt
from emp)
select * from cte
where S=3 or (cnt<3 and S=cnt)
