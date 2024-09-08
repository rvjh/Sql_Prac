use test1;

-- Create the salesman table with updated COMMISSION precision
CREATE TABLE salesman (
    SALESMAN_ID INT(5) NOT NULL PRIMARY KEY,
    NAME VARCHAR(30) NOT NULL,
    CITY VARCHAR(15) NOT NULL,
    COMMISSION DECIMAL(8,2) NOT NULL
);

-- Create the customer table
CREATE TABLE customer (
    CUSTOMER_ID INT(5) NOT NULL PRIMARY KEY,
    CUST_NAME VARCHAR(30) NOT NULL,
    CITY VARCHAR(15) NOT NULL,
    GRADE INT(3) NOT NULL,
    SALESMAN_ID INT(5) NOT NULL,
    FOREIGN KEY (SALESMAN_ID) REFERENCES salesman(SALESMAN_ID)
);

-- Create the orders table
CREATE TABLE orders (
    ORD_NO INT(5) NOT NULL PRIMARY KEY,
    PURCH_AMT DECIMAL(8,2) NOT NULL,
    ORD_DATE DATE NOT NULL,
    CUSTOMER_ID INT(5) NOT NULL,
    SALESMAN_ID INT(5) NOT NULL,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES customer(CUSTOMER_ID),
    FOREIGN KEY (SALESMAN_ID) REFERENCES salesman(SALESMAN_ID)
);

-- Insert dummy values into the salesman table
INSERT INTO salesman (SALESMAN_ID, NAME, CITY, COMMISSION) VALUES
(1, 'John Doe', 'New York', 1500.00),
(2, 'Jane Smith', 'Los Angeles', 1800.00),
(3, 'Emily Davis', 'Chicago', 1600.00);

-- Insert dummy values into the customer table
INSERT INTO customer (CUSTOMER_ID, CUST_NAME, CITY, GRADE, SALESMAN_ID) VALUES
(1, 'Acme Corp', 'New York', 1, 1),
(2, 'Beta LLC', 'Los Angeles', 2, 2),
(3, 'Gamma Inc', 'Chicago', 1, 3);

-- Insert dummy values into the orders table
INSERT INTO orders (ORD_NO, PURCH_AMT, ORD_DATE, CUSTOMER_ID, SALESMAN_ID) VALUES
(1001, 2500.00, '2024-09-01', 1, 1),
(1002, 1800.00, '2024-09-02', 2, 2),
(1003, 2200.00, '2024-09-03', 3, 3);

select * from salesman;
select * from customer;
select * from orders;

-------------------------------------------------

-- write a SQL query to find the salesperson and customer who reside in the same 
-- city. Return Salesman, cust_name and city.

select salesman.name, customer.cust_name, customer.city from
salesman join orders join customer
on salesman.SALESMAN_ID = orders.SALESMAN_ID and orders.CUSTOMER_ID = customer.CUSTOMER_ID
where salesman.city = customer.city;

-- or

select salesman.name, customer.cust_name, customer.city from
salesman join customer
on salesman.SALESMAN_ID =  customer.SALESMAN_ID
where salesman.city = customer.city;

--------------------------------------------------------------------

-- find those orders where the order amount exists between 500 and 2000. 
-- Return ord_no, purch_amt, cust_name, city.

select orders.ord_no, orders.purch_amt, customer.cust_name, customer.city
from orders join customer
where orders.customer_id = customer.customer_id and orders.purch_amt between 500 and 2000;
--------------------------------------------------------------------------------
--- to find the salesperson(s) and the customer(s) he represents. 
--- Return Customer Name, city, Salesman, commission.

select salesman.name as Salesman_Name, customer.cust_name, customer.city, salesman.commission  
from salesman, customer
where salesman.SALESMAN_ID =  customer.SALESMAN_ID;

---------------------------------------------------------------------------
-- ind salespeople who received commissions of more than 1500 from the company. 
-- Return Customer Name, customer city, Salesman, commission.  

select salesman.name as Salesman_Name, customer.cust_name, customer.city, salesman.commission  
from salesman, customer
where salesman.SALESMAN_ID =  customer.SALESMAN_ID and salesman.commission > 1500;

----------------------------------------------------------------------------------
--  locate those salespeople who do not live in the same city where their customers live and have 
-- received a commission of more than 12% from the company. 
-- Return Customer Name, customer city, Salesman, salesman city, commission.  

select salesman.name as Salesman_Name, customer.cust_name, customer.city, salesman.commission  
from salesman join customer
on salesman.SALESMAN_ID =  customer.SALESMAN_ID 
where salesman.commission > 1200 and salesman.city != customer.city;

----------------------------------------------------
-- details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission.

select orders.ord_no, orders.ord_date, orders.purch_amt, customer.cust_name, 
	   customer.grade, salesman.name, salesman.commission
from orders join customer join salesman
on salesman.salesman_id = orders.salesman_id and orders.customer_id = customer.customer_id;

--------------------------------------------------------
-- SQL query to display the customer name, customer city, grade, salesman, salesman city. 
-- The results should be sorted by ascending customer_id

select salesman.name, salesman.city, customer.cust_name, customer.city, customer.grade, customer.customer_id
from salesman, customer
where salesman.salesman_id = customer.salesman_id
order by customer_id asc;

------------------------------------------------------------

