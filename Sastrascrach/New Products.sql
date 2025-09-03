with cte as(
select company_name,
count(distinct (case when year=2020 then product_name end)) as p_2020_cnt,
count(distinct (case when year=2019 then product_name end)) as p_2019_cnt
from car_launches
group by company_name)
select company_name,
(p_2020_cnt - p_2019_cnt) net_products
from cte