select * from stores;

-- find missing quaters

select distinct q_no from(select store, right(quarter,1) q_no from stores) A;

select store,10 - sum(right(quarter,1)) q_no from stores
group by store;


select store, concat('Q',10 - sum(right(quarter,1))) Missing_Quarter from stores
group by store