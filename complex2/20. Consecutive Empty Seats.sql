select * from bms;

-- 3 and more consecutive seats are empty


WITH cte AS (
    SELECT *,
           LAG(is_empty,2) OVER (ORDER BY seat_no) AS prev_2,
           LAG(is_empty,1) OVER (ORDER BY seat_no) AS prev_1,
           LEAD(is_empty,1) OVER (ORDER BY seat_no) AS next_1,
           LEAD(is_empty,2) OVER (ORDER BY seat_no) AS next_2
    FROM bms
)
SELECT seat_no 
FROM cte 
WHERE (is_empty = 'Y' AND next_1 = 'Y' AND next_2 = 'Y')
   OR (is_empty = 'Y' AND prev_1 = 'Y' AND next_1 = 'Y')
   OR (is_empty = 'Y' AND prev_1 = 'Y' AND prev_2 = 'Y')
order by seat_no;






