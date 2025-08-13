select count(*) duplicate_companies
from(
SELECT company_id,count(*) no_of_post
FROM job_listings
group by company_id, title
having count(*)>1) A