select * from int_orders;

-- largest order value for each salesperson and display order details

select A.order_number, A.order_date, A.cust_id, A.salesperson_id, A.amount from int_orders A
left join int_orders B 
on A.salesperson_id = B.salesperson_id
group by A.order_number, A.order_date, A.cust_id, A.salesperson_id, A.amount
having A.amount >= max(B.amount)