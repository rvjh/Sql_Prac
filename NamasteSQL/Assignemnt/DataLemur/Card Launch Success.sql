select card_name, issued_amount from(
with cte as(
SELECT * 
, row_number() over(PARTITION by card_name 
                    order by issue_year,issue_month asc) rn
FROM monthly_cards_issued)
select * from cte where rn=1) A
order by issued_amount desc;