with cte as(
SELECT manufacturer, drug, (total_sales - cogs) as net_amt
FROM pharmacy_sales
where (total_sales - cogs)<= 0)
select manufacturer, count(drug), abs(sum(net_amt)) total_loss  
from cte
GROUP by manufacturer
ORDER by sum(net_amt) asc;