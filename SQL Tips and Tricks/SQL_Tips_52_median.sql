select * from emp_v3;

-- median of emp_age

select 
case when count(emp_id)%2 != 0 then count(emp_id)/2 else (count(emp_id)/2)+1 end median
from
(select * from emp_v3
order by emp_age asc) A;


WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY emp_age) AS rn_asc,
           COUNT(*) OVER () AS total_count
    FROM emp_v3
)
SELECT AVG(emp_age) AS median
FROM cte
WHERE rn_asc = (total_count + 1) / 2
   OR rn_asc = (total_count + 2) / 2;

