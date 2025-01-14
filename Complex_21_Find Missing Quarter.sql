select * from stores;

-- Missing quaters

SELECT store,RIGHT(Quarter, 1) AS Quarter_N0, amount
FROM stores;

SELECT store,10 - sum(RIGHT(Quarter, 1)) Q_No
FROM stores group by store;

SELECT store, CONCAT('Q', 10 - SUM(RIGHT(Quarter, 1))) AS Q_No
FROM stores
GROUP BY store;




