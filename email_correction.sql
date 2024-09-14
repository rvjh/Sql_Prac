CREATE TABLE employees  (employee_id int,employee_name varchar(15), email_id varchar(15) );

INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('101','Liam Alton', 'li.al@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('102','Josh Day', 'jo.da@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('103','Sean Mann', 'se.ma@abc.com'); 
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('104','Evan Blake', 'ev.bl@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('105','Toby Scott', 'jo.da@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('106','Anjali Chouhan', 'JO.DA@ABC.COM');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('107','Ankit Bansal', 'AN.BA@ABC.COM');

-- i dont want duplicase i.e. i want only lower case email id in case of duplicate

select * from employees

select employee_id, employee_name, email_id, lower(email_id) as l_email_id
from employees

WITH cte AS (
    SELECT
        employee_id,
        email_id,
        ROW_NUMBER() OVER (partition by email_id ORDER BY ascii(email_id) desc) AS rn
    FROM employees
)
SELECT *
FROM cte
WHERE rn = 1;


