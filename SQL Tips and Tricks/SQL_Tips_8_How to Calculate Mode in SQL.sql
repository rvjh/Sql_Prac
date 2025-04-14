create table mode 
(
id int
);

insert into mode values (1),(2),(2),(3),(3),(3),(3),(4),(5);

-- calculate mode

select * from mode;

-- with cte

with cte as(
select id, count(1) cnt from mode group by id)
select id as mode from cte where cnt in (select max(cnt) from cte);

-- with rank

insert into mode values (4);
insert into mode values (4);
insert into mode values (4);
insert into mode values (4);
insert into mode values (3);

select * from mode;

with cte as(
select id, count(1) cnt from mode group by id)
select id, cnt as mode from cte where cnt in (select max(cnt) from cte);


with cte2 as(
select id, count(1) cnt from mode group by id)
, cte3 as(
select *, rank() over(order by cnt desc) rn from cte2)
select id, cnt from cte3 where rn=1;




