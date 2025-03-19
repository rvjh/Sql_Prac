use test1;

create table numbers (n int);
insert into numbers values (1),(2),(3),(4),(5);
insert into numbers values (9);

select * from numbers;

-- 

WITH RECURSIVE cte AS (
    SELECT n, 1 AS num_count 
    FROM numbers
    UNION ALL
    SELECT n, num_count + 1 AS num_count 
    FROM cte
    WHERE num_count + 1 <= n
)
SELECT n 
FROM cte
ORDER BY n;

-- without recursive cte

select n1.n, n2.n 
from numbers n1
inner join numbers n2 on 1=1
where n1.n>=n2.n
order by n1.n, n2.n;


select n1.n
from numbers n1
inner join numbers n2 on 1=1
where n1.n>=n2.n
order by n1.n, n2.n
