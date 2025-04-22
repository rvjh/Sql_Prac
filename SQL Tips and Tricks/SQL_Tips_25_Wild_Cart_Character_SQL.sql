select * from orders3;

select order_id, order_date, customer_name from orders3;

-- exact match 
select order_id, order_date, customer_name 
from orders3 where customer_name = 'Ann Blume';

-- starts with Ann
select order_id, order_date, customer_name 
from orders3 where customer_name like 'Ann%';

-- ends with ez
select order_id, order_date, customer_name 
from orders3 where customer_name like '%ez';

-- stats with a end with n
select order_id, order_date, customer_name 
from orders3 where customer_name like 'a%n';

-- contains 
select order_id, order_date, customer_name 
from orders3 where customer_name like '%ra%';

-- for character _
select order_id, order_date, customer_name 
from orders3 where customer_name like '_a%';

select order_id, order_date, customer_name 
from orders3 where customer_name like '_a_b%';

select order_id, order_date, customer_name 
from orders3 where customer_name like '%a_a_';

select order_id, order_date, customer_name 
from orders3 where customer_name like '___a%';

-- [] can contain anything

select order_id, order_date, customer_name 
from orders3 where customer_name like '_p%';









