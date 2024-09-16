create table users_1 (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders_1 (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items_1
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into users_1 values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items_1 values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders_1 values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);
 
select * from users_1;
select * from items_1;
select * from orders_1;

-- to find for each seller whether the brand of the second item ( by date) they sold is their favourite
-- if the seller sold less than 2 items the show results as no 

with rank_orders as(
select *,
rank() over(partition by seller_id order by order_date asc) as rn
from orders_1
)
select * from rank_orders where rn=2;


with rank_orders as(
select *,
rank() over(partition by seller_id order by order_date asc) as rn
from orders_1
)
select * ,
case when item_brand = favorite_brand then "yes" else "no" end as second_item_favourite
from users_1 u
left join rank_orders ro on ro.seller_id = u.user_id and rn=2
left join items_1 on ro.item_id = items_1.item_id