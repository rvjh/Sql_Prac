select * from covid;


WITH cte AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY days ASC) AS rn,
           RANK() OVER (PARTITION BY city ORDER BY cases ASC) AS rn1
    FROM covid
),
diffs AS (
    SELECT city, 
           CAST(rn AS SIGNED) - CAST(rn1 AS SIGNED) AS r
    FROM cte
)
SELECT city
FROM diffs
GROUP BY city
HAVING COUNT(DISTINCT r) = 1 AND AVG(r) = 0;


