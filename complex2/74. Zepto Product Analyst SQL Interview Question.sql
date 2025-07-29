select * from numbers;


-- number times


WITH RECURSIVE cte AS (
    SELECT n, 1 AS num_counter 
    FROM numbers
    UNION ALL
    SELECT c.n, c.num_counter + 1 
    FROM cte c
    WHERE c.num_counter + 1 <= c.n
)
SELECT * FROM cte order by n;


-- 

select n2.n
from numbers n1
inner join numbers n2 on 1=1
where n1.n <= n2.n;


