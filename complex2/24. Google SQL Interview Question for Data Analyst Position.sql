select * from company_users;

-- companies with atleast two  users who speaks english and german both

select A.company_id, A.user_id, A.language, B.language
from
(select * from company_users where language = "English") A
inner join 
(select * from company_users where language = "German") B
on A.company_id = B.company_id and A.user_id = B.user_id
group by A.company_id, A.user_id, A.language, B.language
having count(1)=2;

select company_id from(
select company_id, user_id, count(1) c
from company_users
where language in ("English", "German")
group by company_id, user_id
having count(1)=2) A
group by company_id
having count(1)>=2;
