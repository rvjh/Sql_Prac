CREATE TABLE Orders_Blinkit (
    customer_id INT,
    order_date DATE,
    coupon_code VARCHAR(50)
);

-- TRUNCATE TABLE Orders_Blinkit;

-- ✅ Customer 1: First order in Jan, valid pattern
INSERT INTO Orders_Blinkit VALUES (1, '2025-01-10', NULL);
INSERT INTO Orders_Blinkit VALUES (1, '2025-02-05', NULL);
INSERT INTO Orders_Blinkit VALUES (1, '2025-02-20', NULL);
INSERT INTO Orders_Blinkit VALUES (1, '2025-03-01', NULL);
INSERT INTO Orders_Blinkit VALUES (1, '2025-03-10', NULL);
INSERT INTO Orders_Blinkit VALUES (1, '2025-03-15', 'DISC10'); -- last order with coupon ✅

-- ✅ Customer 2: First order in Feb, valid pattern
INSERT INTO Orders_Blinkit VALUES (2, '2025-02-02', NULL);   -- Month1 = 1
INSERT INTO Orders_Blinkit VALUES (2, '2025-02-05', NULL);   -- Month1 = 1
INSERT INTO Orders_Blinkit VALUES (2, '2025-03-05', NULL);   -- Month2 = 2
INSERT INTO Orders_Blinkit VALUES (2, '2025-03-18', NULL);
INSERT INTO Orders_Blinkit VALUES (2, '2025-03-20', NULL);   -- Month2 = 2
INSERT INTO Orders_Blinkit VALUES (2, '2025-03-22', NULL);
INSERT INTO Orders_Blinkit VALUES (2, '2025-04-02', NULL);   -- Month3 = 3
INSERT INTO Orders_Blinkit VALUES (2, '2025-04-10', NULL);
INSERT INTO Orders_Blinkit VALUES (2, '2025-04-15', 'DISC20'); -- last order with coupon ✅
INSERT INTO Orders_Blinkit VALUES (2, '2025-04-16', NULL);   -- Month3 = 3
INSERT INTO Orders_Blinkit VALUES (2, '2025-04-18', NULL);
INSERT INTO Orders_Blinkit VALUES (2, '2025-04-20', 'DISC20'); -- last order with coupon ✅

-- ❌ Customer 3: First order in March but wrong multiples
INSERT INTO Orders_Blinkit VALUES (3, '2025-03-05', NULL);  -- Month1 = 1
INSERT INTO Orders_Blinkit VALUES (3, '2025-04-10', NULL);  -- Month2 should have 2, but only 1 ❌
INSERT INTO Orders_Blinkit VALUES (3, '2025-05-15', 'DISC30');

-- ❌ Customer 4: First order in Feb but missing March (gap)
INSERT INTO Orders_Blinkit VALUES (4, '2025-02-01', NULL);  -- Month1
INSERT INTO Orders_Blinkit VALUES (4, '2025-04-05', 'DISC40'); -- Skipped March ❌

-- ❌ Customer 5: Valid multiples but last order has no coupon
INSERT INTO Orders_Blinkit VALUES (5, '2025-01-03', NULL);  -- M1 = 1
INSERT INTO Orders_Blinkit VALUES (5, '2025-02-05', NULL);  -- M2 = 2
INSERT INTO Orders_Blinkit VALUES (5, '2025-02-15', NULL);
INSERT INTO Orders_Blinkit VALUES (5, '2025-03-01', NULL);  -- M3 = 3
INSERT INTO Orders_Blinkit VALUES (5, '2025-03-08', 'DISC50'); -- coupon mid
INSERT INTO Orders_Blinkit VALUES (5, '2025-03-20', NULL);     -- last order no coupon ❌

-- ❌ Customer 6: Skips month 2, should be excluded
INSERT INTO Orders_Blinkit VALUES (6, '2025-01-05', NULL);     -- Month1 = 1 order
-- (no Orders_Blinkit in Feb, so Month2 is missing ❌)
INSERT INTO Orders_Blinkit VALUES (6, '2025-03-02', NULL);     -- Month3 = 1st order
INSERT INTO Orders_Blinkit VALUES (6, '2025-03-15', NULL);     -- Month3 = 2nd order
-- Jump to May (Month5 relative to Jan)
INSERT INTO Orders_Blinkit VALUES (6, '2025-05-05', NULL);     
INSERT INTO Orders_Blinkit VALUES (6, '2025-05-10', NULL);     
INSERT INTO Orders_Blinkit VALUES (6, '2025-05-25', 'DISC60'); -- Last order with coupon

-- no of new customers who satisfies the below conditions : 
-- placed at least one orders on 3 consecutive months (like jan feb march / sep oct nov ) d
-- no of ordrs in secord mon = 2*first month
-- no of ordrs in third mon =  3* first month
-- last order(latest order) cuopon code is not null  d


WITH coupon_cte AS (
    SELECT customer_id
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
        FROM Orders_Blinkit
    ) A
    WHERE rn = 1 AND coupon_code IS NOT NULL
),

monthly_orders AS (
    SELECT customer_id,
           MONTH(order_date) AS month,
           COUNT(*) AS order_count
    FROM Orders_Blinkit
    WHERE customer_id IN (SELECT customer_id FROM coupon_cte)
    GROUP BY customer_id, MONTH(order_date)
),

joined_orders AS (
    SELECT 
        a.customer_id
    FROM monthly_orders a
    JOIN monthly_orders b ON a.customer_id = b.customer_id  AND b.month = a.month + 1 
    JOIN monthly_orders c ON a.customer_id = c.customer_id  AND c.month = a.month + 2
)
, count_cond as(
select *  from monthly_orders
where customer_id in (select customer_id from joined_orders) and order_count >= 1)
select count(distinct c1.customer_id) no_of_new_cust
from count_cond c1 
inner join count_cond c2 on c1.customer_id = c2.customer_id and c1.order_count * 2 = c2.order_count
inner join count_cond c3 on c1.customer_id = c3.customer_id and c1.order_count * 3 = c3.order_count

