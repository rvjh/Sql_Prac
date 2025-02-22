select * from candidates_v2;

with r_cte as(
select *,
sum(salary) over(partition by positions order by salary asc, id) rsal 
 from candidates_v2)
 , cte_senior as(
 select * from r_cte where positions='senior' and rsal<50000)
 select * from r_cte where positions='junior' and 50000 - (select sum(salary) from cte_senior)
 union all 
 select * from cte_senior;
 
 
 with r_cte as(
select *,
sum(salary) over(partition by positions order by salary asc, id) rsal 
 from candidates_v2)
 , cte_senior as(
 select count(*) seniors, sum(salary) s_sal from r_cte where positions='senior' and rsal<50000)
 , junior_cte as(
 select count(*) juniors from r_cte where positions='junior' and 50000 - (select s_sal from cte_senior))

select juniors, seniors  from junior_cte, cte_senior