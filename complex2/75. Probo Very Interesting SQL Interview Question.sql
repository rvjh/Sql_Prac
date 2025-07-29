select * from polls;
select * from poll_answers;


-- 

with cte as(
select polls.*, poll_answers.correct_option_id
from polls 
inner join poll_answers on polls.poll_id = poll_answers.poll_id)
, correct_options_cte as(
select * from cte 
where poll_option_id = correct_option_id
)
, wrong_options_cte as(
select poll_id, sum(amount) t from cte 
where poll_option_id != correct_option_id
group by poll_id),
poll_corr_sum as(
select poll_id, sum(amount) s_c from correct_options_cte group by poll_id)
, per_cal as(
select correct_options_cte.poll_id, correct_options_cte.user_id, 
correct_options_cte.amount / poll_corr_sum.s_c as pct
from correct_options_cte
inner join poll_corr_sum on correct_options_cte.poll_id = poll_corr_sum.poll_id)
select wrong_options_cte.poll_id, per_cal.user_id,
(wrong_options_cte.t)*(per_cal.pct) as amount_win
from wrong_options_cte
inner join per_cal on    per_cal.poll_id = wrong_options_cte.poll_id;



