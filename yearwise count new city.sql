create table business_city (
business_date date,
city_id int
);

insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);

select * from business_city;

-- yearwise count of new cities where uddan has started its operation

with cte as(
select year(business_date) buss_year, city_id
from business_city)
select c1.*, c2.*
from cte c1 left join cte c2 on c1.city_id = c2.city_id and c1.buss_year> c2.buss_year;

with cte as(
select year(business_date) buss_year, city_id
from business_city)
select c1.buss_year, count(distinct case when c2.city_id is null then c1.city_id end) new_city
from cte c1 left join cte c2 on c1.city_id = c2.city_id and c1.buss_year> c2.buss_year
group by c1.buss_year;
