select * from emp;


-- emp with 3rd highest salary in each dept
-- incase dept has less than 3 emp then return emp with less salary

with cte as(
select emp_id, emp_name, salary, dep_id, dep_name,
rank() over(partition by dep_id order by salary desc) rn,
count(1) over(partition by dep_id) emp_cnt
from emp)
select * from cte;

with cte as(
select emp_id, emp_name, salary, dep_id, dep_name,
rank() over(partition by dep_id order by salary desc) rn,
count(1) over(partition by dep_id) emp_cnt
from emp)
select * from cte where rn=3 or (emp_cnt<3 and rn=emp_cnt)