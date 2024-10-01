create table emp_v3(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp_v3
values
(1, 'Ankit', 100,10000, 4, 39);
insert into emp_v3
values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp_v3
values (3, 'Vikas', 100, 10000,4,37);
insert into emp_v3
values (4, 'Rohit', 100, 5000, 2, 16);
insert into emp_v3
values (5, 'Mudit', 200, 12000, 6,55);
insert into emp_v3
values (6, 'Agam', 200, 12000,2, 14);
insert into emp_v3
values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp_v3
values (8, 'Ashish', 200,5000,2,12);
insert into emp_v3
values (9, 'Mukesh',300,6000,6,51);
insert into emp_v3
values (10, 'Rakesh',300,7000,6,50);

select * from emp_v3;

-- 

select department_id, avg(salary) dept_avg
from emp_v3
group by department_id;

with cte as(
select department_id, avg(salary) dept_avg, count(*) as no_of_emp, sum(salary) total_dep_sal
from emp_v3
group by department_id
)
select * from(
select e1.department_id, e1.dept_avg,
	   sum(e2.no_of_emp) no_of_emp , sum(e2.total_dep_sal) total_sal,
       sum(e2.total_dep_sal)/sum(e2.no_of_emp) company_avg_sal
from cte e1 inner join cte e2 on e1.department_id != e2.department_id
group by e1.department_id) A
where dept_avg < company_avg_sal;