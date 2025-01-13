select * from bms;

-- find seats where 3 or more consecutive seats are empty

-- using lead, lag

select *,
lag(is_empty,1) over(order by seat_no) prev_1,
lag(is_empty,2) over(order by seat_no) prev_2,
lead(is_empty,1) over(order by seat_no) next_1,
lead(is_empty,2) over(order by seat_no) next_2
from bms;


select * from (
select *,
lag(is_empty,1) over(order by seat_no) prev_1,
lag(is_empty,2) over(order by seat_no) prev_2,
lead(is_empty,1) over(order by seat_no) next_1,
lead(is_empty,2) over(order by seat_no) next_2
from bms) A
where (is_empty='Y' and prev_1='Y' and prev_2='Y')
or (is_empty='Y' and prev_1='Y' and next_1='Y')
or (is_empty='Y' and next_1='Y' and next_2='Y')
order by seat_no;

-- method 2

select * from(
select *,
sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between 2 preceding and current row) prev_2,
sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between 1 preceding and 1 following) prev_next_1,
sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between current row and 2 following) next_2
from bms) A
where prev_2=3 or prev_next_1=3 or next_2=3;

-- mrthod 3

WITH cte AS (
    SELECT *,
        ROW_NUMBER() OVER (ORDER BY seat_no) AS rn,
        (seat_no - ROW_NUMBER() OVER (ORDER BY seat_no)) AS d
    FROM bms
    WHERE is_empty = 'Y'
),
cte_1 AS (
    SELECT d, COUNT(*) AS cnt
    FROM cte 
    GROUP BY d 
    HAVING COUNT(*) >= 3
)
SELECT * 
FROM cte 
WHERE d IN (SELECT d FROM cte_1);
