create table list (id varchar(5));
insert into list values ('a');
insert into list values ('a');
insert into list values ('b');
insert into list values ('c');
insert into list values ('c');
insert into list values ('c');
insert into list values ('d');
insert into list values ('d');
insert into list values ('e');

select * from list;


with cte_dup as(
select id from list group by id having count(1)>1)
, cte_rn as(
select *, rank() over(order by id asc) un from cte_dup)
select list.id, concat('DUP',cte_rn.un) as new_st
from list left join cte_rn on list.id = cte_rn.id