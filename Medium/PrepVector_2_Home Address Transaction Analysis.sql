CREATE TABLE transactions_6 (
id INT PRIMARY KEY,
user_id INT,
created_at DATETIME,
shipping_address VARCHAR(255)
);

-- Transactions sample data
INSERT INTO transactions_6 (id, user_id, created_at, shipping_address) VALUES
(1, 1, '2025-01-15 10:30:00', '123 Main St'), 
(2, 1, '2025-01-16 11:45:00', '789 Oak Ave'), 
(3, 2, '2025-01-17 14:20:00', '456 Elm St'), 
(4, 2, '2025-01-18 15:10:00', '123 Pine Rd'), 
(5, 3, '2025-01-19 16:05:00', '789 Oak Ave'), 
(6, 3, '2025-01-20 17:40:00', '123 Main St'),
(7, 3, '2025-01-21 17:45:00', '123 Main St');

CREATE TABLE users_6 (
id INT PRIMARY KEY,
name VARCHAR(255),
address VARCHAR(255)
);

-- Users sample data
INSERT INTO users_6 (id, name, address) VALUES
(1, 'John Doe', '123 Main St'),
(2, 'Jane Smith', '456 Elm St'),
(3, 'Alice Johnson', '789 Oak Ave');

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

select * from users_6;
select * from transactions_6;

WITH cte AS (
    SELECT 
	t.id,t.user_id,t.shipping_address, u.address AS user_address
    FROM transactions_6 t JOIN users_6 u ON t.user_id = u.id
),
home_address_transactions AS (
    SELECT 
	COUNT(id) AS home_transaction_count
    FROM cte
	WHERE shipping_address = user_address
),
total_transactions AS (
    SELECT 
        COUNT(id) AS total_transaction_count
    FROM transactions_6
)
SELECT 
ROUND((SELECT home_transaction_count FROM home_address_transactions) * 100.0 /
	  (SELECT total_transaction_count FROM total_transactions),2) AS home_address_percent;

