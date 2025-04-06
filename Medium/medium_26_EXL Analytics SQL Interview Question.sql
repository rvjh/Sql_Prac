select * from city_population ;


with cte as(
select *,
max(population) over(partition by state) max_pop,
min(population) over(partition by state) min_pop
from city_population)
select state,
max(case when population=min_pop then city end) as min_pop_city,
max(case when population=max_pop then city end) as max_pop_city
from cte
group by state;


with cte as(
select *,
row_number() over(partition by state order by population) rn_min,
row_number() over(partition by state order by population desc) rn_max
from city_population)
select state,
max(case when rn_max=1 then city end) max_city,
min(case when rn_min=1 then city end) min_city
from cte
group by state;


