CREATE TABLE transactions7 (
id INT PRIMARY KEY,
credit_card VARCHAR(20),
merchant VARCHAR(50),
amount DECIMAL(10, 2),
transaction_time DATETIME
);

INSERT INTO transactions7 (id, credit_card, merchant, amount, transaction_time)
VALUES
(1, '1234-5678-9876', 'Amazon', 50.00, '2025-01-23 10:15:00'),
(2, '1234-5678-9876', 'Amazon', 50.00, '2025-01-23 10:20:00'),
(3, '5678-1234-8765', 'Walmart', 30.00, '2025-01-23 11:00:00'),
(4, '1234-5678-9876', 'Amazon', 50.00, '2025-01-23 10:30:00'),
(5, '5678-1234-8765', 'Walmart', 30.00, '2025-01-23 11:05:00'),
(6, '8765-4321-1234', 'BestBuy', 100.00, '2025-01-23 12:00:00'),
(7, '1234-5678-9876', 'Amazon', 50.00, '2025-01-23 12:10:00');

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

select * from transactions7;

-- Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. Count such repeated payments.


WITH repeated_payments AS (
    SELECT 
        t1.id AS original_id,
        t2.id AS repeated_id,
        t1.credit_card,
        t1.merchant,
        t1.amount,
        t1.transaction_time AS original_time,
        t2.transaction_time AS repeated_time
    FROM 
        transactions7 t1
    JOIN 
        transactions7 t2 
    ON 
        t1.credit_card = t2.credit_card
        AND t1.merchant = t2.merchant
        AND t1.amount = t2.amount
        AND t2.transaction_time > t1.transaction_time
        AND TIMESTAMPDIFF(MINUTE, t1.transaction_time, t2.transaction_time) <= 10
)
SELECT 
    COUNT(DISTINCT repeated_id) AS repeated_payment_count
FROM 
    repeated_payments;
