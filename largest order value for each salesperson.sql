CREATE TABLE int_orders (
    order_number INT NOT NULL,
    order_date DATE NOT NULL,
    cust_id INT NOT NULL,
    salesperson_id INT NOT NULL,
    amount FLOAT NOT NULL
);

INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (30, '1995-07-14', 9, 1, 460);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (10, '1996-08-02', 4, 2, 540);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (40, '1998-01-29', 7, 2, 2400);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (50, '1998-02-03', 6, 7, 600);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (60, '1998-03-02', 6, 7, 720);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (70, '1998-05-06', 9, 7, 150);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (20, '1999-01-30', 4, 8, 1800);

select * from int_orders;

-- find largest order value for each salesperson and display order details
 
select salesperson_id,
max(amount)
from int_orders
group by salesperson_id;

select A.order_number, A.order_date, A.cust_id, a.salesperson_id, A.amount
from int_orders A left join int_orders B 
on A.salesperson_id = B.salesperson_id
group by A.order_number, A.order_date, A.cust_id, a.salesperson_id, A.amount
having A.amount >= max(B.amount)

