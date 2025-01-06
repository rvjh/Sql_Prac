select * from orders_2;
select * from products_2;


select o1.order_id, o1.product_id p1, o2.product_id p2 from orders_2 o1
inner join orders_2 o2
on o1.order_id = o2.order_id
where o1.order_id=1;


select o1.order_id, o1.product_id p1, o2.product_id p2 from orders_2 o1
inner join orders_2 o2
on o1.order_id = o2.order_id
where o1.product_id > o2.product_id;

select o1.product_id p1, o2.product_id p2, count(1) purchase_cnt from orders_2 o1
inner join orders_2 o2
on o1.order_id = o2.order_id
where o1.product_id > o2.product_id
group by o1.product_id, o2.product_id;

select o1.product_id p1, o2.product_id p2, count(1) purchase_cnt from orders_2 o1
inner join orders_2 o2
on o1.order_id = o2.order_id
inner join products_2 pr1 on pr1.id = o1.product_id
inner join products_2 pr2 on pr2.id = o2.product_id
where o1.product_id > o2.product_id
group by o1.product_id, o2.product_id;


SELECT CONCAT(pr1.name, ' ', pr2.name) AS combined_name, COUNT(1) AS purchase_cnt 
FROM orders_2 o1
INNER JOIN orders_2 o2 ON o1.order_id = o2.order_id
INNER JOIN products_2 pr1 ON pr1.id = o1.product_id
INNER JOIN products_2 pr2 ON pr2.id = o2.product_id
WHERE o1.product_id > o2.product_id
GROUP BY pr1.name, pr2.name;


