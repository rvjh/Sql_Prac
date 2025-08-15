select count(*) policy_holder_count
from(
SELECT policy_holder_id,
count(case_id)  call_cnt
FROM callers
group by policy_holder_id
HAVING count(case_id)>=3) A