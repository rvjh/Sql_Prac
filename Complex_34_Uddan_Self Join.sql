select * from business_city;

-- sql query - yearwise count of city where udan has started operation

with cte as(
select *, year(business_date) yr
from business_city)
select * from cte c1
left join cte c2 on c1.city_id=c2.city_id and c1.yr>c2.yr;


with cte as(
select *, year(business_date) yr
from business_city)
select c1.yr, count(case when c2.yr is null then c1.yr end) cnt
from cte c1
left join cte c2 on c1.city_id=c2.city_id and c1.yr>c2.yr
group by c1.yr
