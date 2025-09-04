with cte as(
select company_name,
count(distinct (case when year=2020 then product_name end)) as p_2020_cnt,
count(distinct (case when year=2019 then product_name end)) as p_2019_cnt
from car_launches
group by company_name)
select company_name,
(p_2020_cnt - p_2019_cnt) net_products

from cte


# Import your libraries
import pandas as pd

# Start writing code
dc_bikeshare_q1_2012.head()

dc_bikeshare_q1_2012.groupby("bike_number")["end_time"].max().reset_index(name="last_used")
