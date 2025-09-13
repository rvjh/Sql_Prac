with cte as(
SELECT account_id,
sum(case when transaction_type = 'Deposit' then amount end) total_dep,
sum(case when transaction_type = 'Withdrawal' then amount end) total_wid
FROM transactions
group by account_id)
select account_id, 
total_dep - total_wid as final_balance
from cte;