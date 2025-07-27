select * from cinema;

-- 2 or more consecutive seats

with cte as(
select *,
row_number() over(order by seat_id) r,
seat_id - row_number() over(order by seat_id) as grp
from cinema
where free=1),
cte2 as(
select *, 
count(1) over(partition by grp) c
from cte)
select seat_id from cte2
where c>1;

-- 

with cte as(
select * 
, lag(free,1) over(order by seat_id) prev_seat
, lead(free,1) over(order by seat_id) next_seat
from cinema),
cte2 as(
select * 
, case when free = 1 and (prev_seat = 1 or next_seat = 1) then seat_id end f
from cte)
select seat_id from cte2 where f is not null;


