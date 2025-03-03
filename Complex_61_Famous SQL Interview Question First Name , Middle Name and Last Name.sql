use test1;

create table customers_str  (customer_name varchar(30));
insert into customers_str values ('Ankit Bansal')
,('Vishal Pratap Singh')
,('Michael'); 

select * from customers_str;

-- segregate fist, middle last name

WITH cte AS (
    SELECT 
        *,
        REPLACE(customer_name, ' ', '') AS rep_name, 
        (LENGTH(customer_name) - LENGTH(REPLACE(customer_name, ' ', ''))) AS spaces,
        INSTR(customer_name, ' ') AS first_space_pos,
        LOCATE(' ', customer_name, INSTR(customer_name, ' ') + 1) AS second_space_pos
    FROM 
        customers_str
)

SELECT
    *,  
    CASE 
        WHEN spaces = 0 THEN customer_name 
        ELSE SUBSTRING(customer_name, 1, first_space_pos - 1) 
    END AS First_Name,
    CASE 
        WHEN spaces <= 1 THEN NULL 
        ELSE SUBSTRING(customer_name, first_space_pos + 1, second_space_pos - first_space_pos - 1) 
    END AS Middle_Name,
    CASE 
        WHEN spaces = 0 THEN NULL 
        WHEN spaces = 1 THEN SUBSTRING(customer_name, first_space_pos + 1) 
        ELSE SUBSTRING(customer_name, second_space_pos + 1) 
    END AS Last_Name
FROM 
    cte;




