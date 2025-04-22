select * from emp;


-- first value, last value

select *,
first_value(emp_name) over(order by salary desc) fv
from emp;

select *,
first_value(emp_name) over(partition by dep_id order by emp_age) fv,
last_value(emp_name) over(order by emp_age rows between current row and unbounded following) fv
from emp;