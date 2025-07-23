select * from customers_str;

-- firstname middlename lastname
-- first replace space with not space

with cte as(
SELECT *,
       REPLACE(customer_name, ' ', '') AS rep_name,
       LENGTH(customer_name) AS len_full,
       LENGTH(REPLACE(customer_name, ' ', '')) AS len_after,
       LENGTH(customer_name) - LENGTH(REPLACE(customer_name, ' ', '')) AS no_of_space,
       LOCATE(' ', customer_name) AS first_space_pos,
       LOCATE(' ', customer_name, LOCATE(' ', customer_name) +1) second_space_pos
FROM customers_str)
select *
, case when no_of_space = 0 then customer_name
	   else substring(customer_name, 1, first_space_pos-1)
       end as first_name
, case when no_of_space<=1 then null
	   else substring(customer_name, first_space_pos+1, second_space_pos-first_space_pos-1)
       end as middle_name
, case when no_of_space = 0 then null
	   when no_of_space = 1 then substring(customer_name, first_space_pos+1, length(customer_name) - first_space_pos)
       when no_of_space = 2 then substring(customer_name, second_space_pos+1, length(customer_name) - second_space_pos)
	   end as last_name
from cte;



