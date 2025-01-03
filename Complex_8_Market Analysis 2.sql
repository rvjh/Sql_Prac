-- market analysis
-- for each seller whether their brand of the second item by date they sold is their favourite brand

select * from orders_1;
select * from users_1;
select * from items_1;


with rnk_orders as(
select * 
, rank() over(partition by seller_id order by order_date asc) rn
from orders_1)
select users_1.user_id,rnk_orders.*,items_1.item_brand, users_1.favorite_brand ,
case when items_1.item_brand = users_1.favorite_brand then "yes" else "no" end as 2nd_item_fav
from users_1
left join rnk_orders on rnk_orders.seller_id = users_1.user_id and rn=2
left join items_1 on rnk_orders.item_id = items_1.item_id;


with rnk_orders as(
select * 
, rank() over(partition by seller_id order by order_date asc) rn
from orders_1)
select users_1.user_id seller_id,
case when items_1.item_brand = users_1.favorite_brand then "yes" else "no" end as 2nd_item_fav
from users_1
left join rnk_orders on rnk_orders.seller_id = users_1.user_id and rn=2
left join items_1 on rnk_orders.item_id = items_1.item_id