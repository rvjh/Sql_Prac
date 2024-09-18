CREATE TABLE orders_2 (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO orders_2 (order_id, customer_id, product_id) VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

CREATE TABLE products_2 (
    id INT NOT NULL PRIMARY KEY,  -- Set PRIMARY KEY with NOT NULL constraint
    name VARCHAR(10) NOT NULL
);

INSERT INTO products_2 (id, name) VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

SELECT * FROM orders_2;
SELECT * FROM products_2;

SELECT o1.order_id, o1.product_id p1, o2.product_id p2 FROM orders_2 o1
inner join orders_2 o2 on o1.order_id = o2.order_id
where o1.product_id > o2.product_id;

SELECT CONCAT(pr1.name,pr2.name) pair, count(1) as purchase_freq FROM orders_2 o1
inner join orders_2 o2 on o1.order_id = o2.order_id
inner join products_2 pr1 on pr1.id = o1.product_id 
inner join products_2 pr2 on pr2.id = o2.product_id 
where o1.product_id > o2.product_id
group by pr1.name, pr2.name


