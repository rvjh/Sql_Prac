CREATE TABLE cinema (
    seat_id INT PRIMARY KEY,
    free int
);

INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 0);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 0);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
INSERT INTO cinema (seat_id, free) VALUES (11, 0);
INSERT INTO cinema (seat_id, free) VALUES (12, 1);
INSERT INTO cinema (seat_id, free) VALUES (13, 0);
INSERT INTO cinema (seat_id, free) VALUES (14, 1);
INSERT INTO cinema (seat_id, free) VALUES (15, 1);
INSERT INTO cinema (seat_id, free) VALUES (16, 0);
INSERT INTO cinema (seat_id, free) VALUES (17, 1);
INSERT INTO cinema (seat_id, free) VALUES (18, 1);
INSERT INTO cinema (seat_id, free) VALUES (19, 1);
INSERT INTO cinema (seat_id, free) VALUES (20, 1);

select * from cinema;

-- consecutive free seat

with cte as(
select *,
row_number() over(order by seat_id) rn,
seat_id - row_number() over(order by seat_id) grp
from cinema 
where free=1),
cte2 as(
select *,
count(*) over(partition by grp) cnt
from cte)
select seat_id from cte2 where cnt>1;

-- method 2

select * from 
cinema c1 inner join cinema c2 on c1.seat_id +1 = c2.seat_id
where c1.free=1 and c2.free=1;


with cte as(
select c1.seat_id s1, c2.seat_id s2 from 
cinema c1 inner join cinema c2 on c1.seat_id +1 = c2.seat_id
where c1.free=1 and c2.free=1
)
select s1 from cte
union 
select s2 from cte;

-- method 3

select * from(
select *,
lag(free,1) over(order by seat_id) prev_free,
lead(free,1) over(order by seat_id) next_free
from cinema) A 
where free=1 and (prev_free=1 or next_free=1)
order by seat_id
