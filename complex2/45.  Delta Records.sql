create table tbl_orders (
order_id integer,
order_date date
);
insert into tbl_orders
values (1,'2022-10-21'),(2,'2022-10-22'),
(3,'2022-10-25'),(4,'2022-10-25');



select * from tbl_orders;

CREATE TABLE tbl_orders_copy AS
SELECT * FROM tbl_orders;

select * from tbl_orders_copy;


select * from tbl_orders;
insert into tbl_orders
values (5,'2022-10-26'),(6,'2022-10-26');

SET SQL_SAFE_UPDATES = 0;
DELETE FROM tbl_orders WHERE order_id = 1;


select * from tbl_orders_copy;
select * from tbl_orders;


select 
tbl_orders_copy.order_id,
case when a.order_id is null then 'D' else 'A' end as flag
from 
tbl_orders_copy 
left join tbl_orders a on tbl_orders_copy.order_id = a.order_id
where a.order_id is null
union all
select b.order_id,
case when tbl_orders_copy.order_id is null then 'I' else 'A' end as flag
from 
tbl_orders_copy 
right join tbl_orders b on tbl_orders_copy.order_id = b.order_id
where tbl_orders_copy.order_id is null




