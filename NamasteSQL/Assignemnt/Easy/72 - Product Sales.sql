select product_name, sum(total_price) total_sales_amount
from(
select products.product_name, products.price * sales.quantity as total_price
from products
inner join sales 
on products.product_id = sales.product_id) A
group by product_name
order by product_name asc;