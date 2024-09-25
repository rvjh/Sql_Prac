create table movie(
seat varchar(50),occupancy int
);
insert into movie values('a1',1),('a2',1),('a3',0),('a4',0),('a5',0),('a6',0),('a7',1),('a8',1),('a9',0),('a10',0),
('b1',0),('b2',0),('b3',0),('b4',1),('b5',1),('b6',1),('b7',1),('b8',0),('b9',0),('b10',0),
('c1',0),('c2',1),('c3',0),('c4',1),('c5',1),('c6',0),('c7',1),('c8',0),('c9',0),('c10',1);

select * from movie;

-- 3 rows and 10 seats in each row-> find 4 consecutive empty rows

with cte1 as(
SELECT *,
       LEFT(seat, 1) AS row_id,
       CAST(SUBSTR(seat, 2) AS UNSIGNED) AS seat_id
FROM movie)
, cte2 as(
select *,
max(occupancy) over(partition by row_id order by seat_id rows between current row and 3 following) is_4_empty,
count(occupancy) over(partition by row_id order by seat_id rows between current row and 3 following) cnt
from cte1)
, cte3 as(
select * from cte2 where is_4_empty=0 and cnt=4)

select cte2.*
from cte2 inner join cte3 
on cte2.row_id = cte3.row_id and cte2.seat_id between cte3.seat_id and cte3.seat_id + 3



