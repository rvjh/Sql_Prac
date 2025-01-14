-- cities where codiv cases are increasing continiously

select * from covid;

select city,days,cases,
rank() over(partition by city order by days asc) rn_date,
rank() over(partition by city order by cases asc) rn_city
from covid
order by city, days;

WITH cte AS (
    SELECT *,
        RANK() OVER (PARTITION BY city ORDER BY days ASC) AS rn_date,
        RANK() OVER (PARTITION BY city ORDER BY cases ASC) AS rn_city
    FROM covid
)
SELECT city
FROM cte
GROUP BY city
HAVING COUNT(DISTINCT rn_date - rn_city) = 1 AND MAX(rn_date - rn_city) = 0;
