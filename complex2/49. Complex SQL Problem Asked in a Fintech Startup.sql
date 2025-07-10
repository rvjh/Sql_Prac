select * from trade_tbl;


with cte as(
SELECT 
  t1.TRADE_ID AS first_trade,
  t2.TRADE_ID AS second_trade,
  t1.Price AS first_trade_price,
  t2.Price AS second_trade_price,
  TIMESTAMPDIFF(SECOND, t1.Trade_Timestamp, t2.Trade_Timestamp) AS time_diff_seconds
FROM 
  trade_tbl t1
INNER JOIN 
  trade_tbl t2 ON t1.TRADE_ID != t2.TRADE_ID
where TIMESTAMPDIFF(SECOND, t1.Trade_Timestamp, t2.Trade_Timestamp) <10 and TIMESTAMPDIFF(SECOND, t1.Trade_Timestamp, t2.Trade_Timestamp)>0
)
, cte2 as(
select * 
, abs((first_trade_price - second_trade_price)/first_trade_price)*100 price_diff
from cte)
select * from cte2 where price_diff>10;