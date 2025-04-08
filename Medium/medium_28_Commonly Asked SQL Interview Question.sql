select * from seats;

-- swap the id of evry adjacent students
-- if id is odd then id of the last student is not swapped


select *,
case when id=(select max(id) from seats) and id%2=1 then id
	 when id%2=0 then id-1
     else id+1
     end new_id
from seats;


-- or

select *,
case when id=(select max(id) from seats) and id%2=1 then id
	 when id%2=0 then lag(id,1) over(order by id)
     else lead(id,1) over(order by id)
     end new_id
from seats;


select *,
case when id=(select max(id) from seats) and id%2=1 then id
	 when id%2=0 then lag(id,1) over(order by id)
     else lead(id,1,id) over(order by id)
     end new_id
from seats;



