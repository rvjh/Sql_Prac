CREATE TABLE Trade_tbl (
    TRADE_ID VARCHAR(20),
    Trade_Timestamp TIME,
    Trade_Stock VARCHAR(20),
    Quantity INT,
    Price FLOAT
);

INSERT INTO Trade_tbl VALUES ('TRADE1', '10:01:05', 'ITJunction4All', 100, 20);
INSERT INTO Trade_tbl VALUES ('TRADE2', '10:01:06', 'ITJunction4All', 20, 15);
INSERT INTO Trade_tbl VALUES ('TRADE3', '10:01:08', 'ITJunction4All', 150, 30);
INSERT INTO Trade_tbl VALUES ('TRADE4', '10:01:09', 'ITJunction4All', 300, 32);
INSERT INTO Trade_tbl VALUES ('TRADE5', '10:10:00', 'ITJunction4All', -100, 19);
INSERT INTO Trade_tbl VALUES ('TRADE6', '10:10:01', 'ITJunction4All', -300, 19);

select * from Trade_tbl;

-- all trades of the same stocks that happend in the range of 10 seconds
-- price diff is more than 10%

SELECT t1.trade_id, 
	   t2.trade_id, 
       t1.Trade_Timestamp, 
       t2.Trade_Timestamp, 
       TIMESTAMPDIFF(SECOND, t1.Trade_Timestamp, t2.Trade_Timestamp) as time_diff,
       t1.price, t2.price, abs(((t1.price - t2.price)/t1.price)*100) per_diff
FROM Trade_tbl t1 
INNER JOIN Trade_tbl t2 ON t1.Trade_Timestamp < t2.Trade_Timestamp
WHERE TIMESTAMPDIFF(SECOND, t1.Trade_Timestamp, t2.Trade_Timestamp) < 10
	   and abs(((t1.price - t2.price)/t1.price)*100) > 10
ORDER BY t1.trade_id
