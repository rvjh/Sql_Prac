select * from trade_tbl;

-- all couple of trade for same stock that happed in the range of 10 seconds
-- having price diff more than 10%


SELECT 
    a.TRADE_ID AS A, 
    a.Trade_Timestamp AS A_Time, 
    a.Price AS A_Price,
    b.TRADE_ID AS B, 
    b.Trade_Timestamp AS B_Time, 
    b.Price AS B_Price,
    (abs(a.Price - b.Price)/a.Price)*100 Price_Diff_Per
FROM 
    trade_tbl a 
INNER JOIN 
    trade_tbl b 
ON 
    a.TRADE_ID != b.TRADE_ID 
WHERE 
    a.Trade_Timestamp < b.Trade_Timestamp 
    AND TIMESTAMPDIFF(SECOND, a.Trade_Timestamp, b.Trade_Timestamp) < 10
    and (abs(a.Price - b.Price)/a.Price)*100 > 10
ORDER BY 
    a.TRADE_ID

