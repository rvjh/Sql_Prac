select * from int_orders;


select a.order_number, a.order_date, a.cust_id, a.salesperson_id, a.amount from
(select * from int_orders) a
inner join 
(select * from int_orders) b
on a.salesperson_id = b.salesperson_id
group by a.order_number, a.order_date, a.cust_id, a.salesperson_id, a.amount
having a.amount>= max(b.amount)
order by a.amount desc;

