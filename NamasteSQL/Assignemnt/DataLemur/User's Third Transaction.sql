select user_id,spend,transaction_date 
from(
SELECT *, 
row_number() over(PARTITION by user_id order by transaction_date) as rn
FROM transactions) A
where rn=3;