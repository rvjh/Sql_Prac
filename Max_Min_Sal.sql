use test1;

create table employee_v1
(
emp_name varchar(10),
dep_id int,
salary int);

insert into employee_v1 values 
('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000);

select * from employee_v1;

-- Print Highest and Lowest Salary Employees in Each Department

select dep_id, max(salary) as Max_Sal, min(salary) as Min_Sal
from employee_v1
group by dep_id;

WITH cte AS (
    SELECT dep_id, 
           MAX(salary) AS Max_Sal, 
           MIN(salary) AS Min_Sal
    FROM employee_v1
    GROUP BY dep_id
)
SELECT e.dep_id
,max(case when salary = max_sal then emp_name else null end) as max_sal_emp
,max(case when salary = min_sal then emp_name else null end) as min_sal_emp
FROM cte
inner join employee_v1 e on cte.dep_id=e.dep_id
group by e.dep_id

