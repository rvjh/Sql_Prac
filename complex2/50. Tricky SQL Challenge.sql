select * from section_data;


WITH cte2 AS (
    SELECT section, number
    FROM (
        SELECT section, number,
               RANK() OVER (PARTITION BY section ORDER BY number ASC) AS rn
        FROM section_data
    ) A
    WHERE rn > 1
),
cte3 AS (
    SELECT section, number,
           SUM(number) OVER (PARTITION BY section) AS r_sum
    FROM cte2
),
cte4 AS (
    SELECT section, number, r_sum,
           DENSE_RANK() OVER (ORDER BY r_sum DESC) AS r,
           MAX(number) OVER (PARTITION BY section) AS m
    FROM cte3
),
cte5 AS (
    SELECT section, number, r_sum, r, m,
           DENSE_RANK() OVER (PARTITION BY section ORDER BY r_sum ASC, m ASC) AS a
    FROM cte4
    WHERE r < 3
)
SELECT *
FROM cte5;
