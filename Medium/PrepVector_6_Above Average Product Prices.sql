CREATE TABLE products_3 (
product_id INT PRIMARY KEY,
price DECIMAL(10,2)
);

INSERT INTO products_3 (product_id, price) VALUES
(1, 100.00),
(2, 150.00),
(3, 75.00),
(4, 200.00),
(5, 120.00);

CREATE TABLE transactions_3 (
transaction_id INT PRIMARY KEY,
product_id INT,
amount DECIMAL(10,2),
FOREIGN KEY (product_id) REFERENCES products_3(product_id)
);

INSERT INTO transactions_3 (transaction_id, product_id, amount) VALUES
(1, 1, 95.00),
(2, 1, 98.00),
(3, 2, 145.00),
(4, 2, 150.00),
(5, 3, 70.00),
(6, 4, 190.00),
(7, 4, 195.00),
(8, 5, 115.00);

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

-- write a query to return the product ID, product price, and average transaction price 
-- of all products with a price greater than the average transaction price.

select * from products_3;
select * from transactions_3;


with cte as(
select product_id, round(avg(amount),2) avg_price 
from transactions_3
group by product_id)
select products_3.product_id, products_3.price as product_price, cte.avg_price avg_transaction_price
from products_3 left join cte
on products_3.product_id = cte.product_id
where products_3.price > cte.avg_price;

WITH cte AS (
    SELECT 
        product_id, 
        AVG(amount) AS avg_price 
    FROM transactions_3
    GROUP BY product_id
)
SELECT 
    products_3.product_id, 
    products_3.price AS product_price, 
    COALESCE(cte.avg_price, 0) AS avg_transaction_price
FROM products_3
LEFT JOIN cte
ON products_3.product_id = cte.product_id
WHERE products_3.price > COALESCE(cte.avg_price, 0);



