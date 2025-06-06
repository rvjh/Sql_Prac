select * from orders_1;
select * from users_1;
select * from items_1;


with item_rank as(
select *,
rank() over(partition by seller_id order by order_date asc) rn
from orders_1)
, cte2 as(
select item_rank.*,items_1.item_brand  
from item_rank 
inner join items_1 on item_rank.item_id = items_1.item_id
where item_rank.rn =2
)
select cte2.seller_id,
case when users_1.favorite_brand = cte2.item_brand then "Yes" else "No" end Favourite_Item
from users_1
left join cte2 on cte2.seller_id = users_1.user_id


