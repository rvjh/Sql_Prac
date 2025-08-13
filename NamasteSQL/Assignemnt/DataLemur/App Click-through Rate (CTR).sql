select app_id, round(100.0*clk_cnt/imp_cnt,2) ctr
from(
SELECT app_id,
sum(case when event_type = 'impression' then 1 else 0 end) imp_cnt,
sum(case when event_type = 'click' then 1 else 0 end) clk_cnt
FROM events
WHERE timestamp>='2022-01-01' and timestamp < '2023-01-01'
group by app_id) A;