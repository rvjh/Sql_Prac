select * from marketing_campaign;

-- 

select * from marketing_campaign
where user_id in (11,14,25);

-- first day purchase and purchase after first day

with cte as(
SELECT *,
    RANK() OVER(PARTITION BY user_id ORDER BY created_at ASC) AS rn
FROM marketing_campaign
WHERE user_id IN (11, 14, 25))
, first_app_purchase as(
select * from cte where rn=1)
,except_first_app_purchase as(
select * from cte where rn>1)
select 
a.user_id, a.product_id, a.created_at, b.user_id, b.product_id, b.created_at
from except_first_app_purchase a
left join first_app_purchase b on a.user_id = b.user_id and a.product_id = b.product_id;


with cte as(
SELECT *,
    RANK() OVER(PARTITION BY user_id ORDER BY created_at ASC) AS rn
FROM marketing_campaign
WHERE user_id IN (11, 14, 25))
, first_app_purchase as(
select * from cte where rn=1)
,except_first_app_purchase as(
select * from cte where rn>1)
select 
a.user_id, a.product_id, a.created_at, b.user_id, b.product_id, b.created_at
from except_first_app_purchase a
left join first_app_purchase b on a.user_id = b.user_id and a.product_id = b.product_id
where b.product_id is null