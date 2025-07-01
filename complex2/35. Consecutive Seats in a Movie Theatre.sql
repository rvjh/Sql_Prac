select * from movie;

-- 3 rows 10 seats each row  find 4 consecutive empty seats

with cte as(
select *, 
left(seat,1) row_id, right(seat,1) seat_id
from movie)
, cte2 as(
select *,
max(occupancy) over(partition by row_id order by seat_id rows between current row and 3 following) 4_rmpty,
count(occupancy) over(partition by row_id order by seat_id rows between current row and 3 following) cnt
from cte)
, cte3 as(
select * from cte2 where 4_rmpty=0 and cnt=4)
select cte2.*
from cte2 inner join cte3 
on cte2.row_id = cte3.row_id and cte2.seat_id between cte3.seat_id and cte3.seat_id+3


