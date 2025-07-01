select * from business_city;

-- yearwise count of new citis

with cte as(
select *,
year(business_date) y,
row_number() over(partition by city_id order by year(business_date) asc) rn
from business_city)
select y, count(rn) count
from cte 
where rn=1
group by y;





