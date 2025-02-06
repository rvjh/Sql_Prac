select * from movie;

-- 3 rows with 10 seats
-- write a sql query to find 4 consecutive empty seats

select *,
left(seat,1) row_id, substr(seat,2,2) seat_no
from movie;

WITH cte AS (
    SELECT *,
        LEFT(seat, 1) AS row_id,
        CAST(SUBSTRING(seat, 2, 2) AS UNSIGNED) AS seat_id
    FROM movie
)
SELECT *,
    MAX(occupancy) OVER (PARTITION BY row_id ORDER BY seat_id ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS is_4_empty
FROM cte;


WITH cte AS (
    SELECT *,
        LEFT(seat, 1) AS row_id,
        CAST(SUBSTRING(seat, 2, 2) AS UNSIGNED) AS seat_id
    FROM movie
), cte2 as(
SELECT *,
    MAX(occupancy) OVER (PARTITION BY row_id ORDER BY seat_id ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS is_4_empty,
    count(occupancy) OVER (PARTITION BY row_id ORDER BY seat_id ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS cnt_4
FROM cte), 
cte3 as(
select * from cte2 where is_4_empty=0 and cnt_4=4)
select cte2.* from cte2
inner join cte3 on cte2.row_id = cte3.row_id and cte2.seat_id between cte3.seat_id and cte3.seat_id+3