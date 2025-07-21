select * from namaste_orders;
select * from namaste_returns;


-- cities where not even a single order was returned

select namaste_orders.city, count(namaste_returns.order_id) return_order
from namaste_orders left join namaste_returns 
on namaste_orders.order_id = namaste_returns.order_id
group by namaste_orders.city
having count(namaste_returns.order_id) = 0;



