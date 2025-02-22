select * from emp_v2;


with cte as(
select department_id, avg(salary) dept_avg, count(*) no_of_emp, sum(salary) total_dept_sal 
from emp_v2
group by department_id)
select * from(
select e1.department_id, e1.dept_avg, sum(e2.no_of_emp) no_of_emp, 
sum(e2.total_dept_sal) total_salary, sum(e2.total_dept_sal)/sum(e2.no_of_emp) company_avg_Sal
from cte e1 inner join cte e2 on e1.department_id != e2.department_id
group by e1.department_id, e1.dept_avg) A
where dept_avg < company_avg_Sal



