create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);

select * from products;
select * from customer_budget;

-- how many products fails into customer budget along with list of products
-- in case of clash choose less costly product

select * from products;
select * from customer_budget;

with running_cost as(
select *,
sum(cost) over(order by cost asc) r_cost
from products)
select customer_budget.customer_id, 
	   customer_budget.budget, 
       count(1) no_od_prod,  
       group_concat(running_cost.product_id) products_name
from
customer_budget left join running_cost
on running_cost.r_cost < customer_budget.budget
group by customer_id, budget


