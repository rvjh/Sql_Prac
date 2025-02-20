use test1;

select * from section_data;

-- 

with cte as (
select *,
sum(number) over(partition by section order by number desc) as val,
row_number() over(partition by section order by number desc) as rn from section_data)
,section_info as(
select *,dense_rank() over(order by val desc,number asc)  as dnr from cte where rn<=2)
select section,number from section_info where rn<=2 and
section in (select section from section_info where dnr<=2)
order by section asc,number desc;