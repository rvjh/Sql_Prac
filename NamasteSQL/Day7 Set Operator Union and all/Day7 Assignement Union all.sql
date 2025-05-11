select * from icc_world_cup;

-- 1- write a query to produce below output from icc_world_cup table.
-- team_name, no_of_matches_played , no_of_wins , no_of_losses


select team, count(1) no_of_matches, sum(team_winner) no_of_wins, (count(1) - sum(team_winner)) no_of_loss
from(
select team_1 as team, 
case when Team_1 = Winner then 1 else 0 end team_winner
from icc_world_cup
union all
select team_2 as team, 
case when Team_2 = Winner then 1 else 0 end team_winner
from icc_world_cup) A
group by team
order by no_of_matches desc;

-- 3- write a query to print below output using drivers table. Profit rides are the 
-- no of rides where end location of a ride is same as start location of immediate next 
-- ride for a driver
-- id, total_rides , profit_rides

select * from drivers;


with rides as (
select *,row_number() over(partition by id order by start_time asc) as rn
from drivers)
select r1.id , count(1) total_rides, count(r2.id) as profit_rides
from rides r1
left join rides r2
on r1.id=r2.id and r1.end_loc=r2.start_loc and r1.rn+1=r2.rn
group by r1.id;

with cte as(
select *, row_number() over(partition by id order by start_time) rn
from drivers)
select c1.id, count(1) total_rides, count(c2.id) profit_rides
from cte c1 left join cte c2 on c1.id = c2.id and c1.end_loc = c2.start_loc and c1.rn+1 = c2.rn
group by c1.id;


-- 5 -write a query to print below output from orders data. example output
-- hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
-- category , Technology, ,
-- category, Furniture, ,
-- category, Office Supplies, ,
-- sub_category, Art , ,
-- sub_category, Furnishings, ,
-- and so on all the category ,subcategory and ship_mode hierarchies

select 
'category' as hierarchy_type,category as hierarchy_name
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders3
group by category
union all
select 
'sub_category',sub_category
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders3
group by sub_category
union all
select 
'ship_mode ',ship_mode 
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders3
group by ship_mode ;

-- 6- the first 2 characters of order_id represents the country of order placed . 
-- write a query to print total no of orders placed in each country
-- (an order can have 2 rows in the data when more than 1 item was purchased in the order 
-- but it should be considered as 1 order)

select * from orders3;

select left(order_id,2) country_name, count(1) total_order
from
(select distinct order_id from orders3) A
group by left(order_id,2);

select left(order_id,2) as country, count(distinct order_id) as total_orders
from orders3
group by left(order_id,2);








