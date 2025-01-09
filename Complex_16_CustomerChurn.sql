select * from transactions;


-- customer churn

SELECT month(this_month.order_date) month_num, count(last_month.cust_id) no_of_retain_cust
FROM transactions this_month
LEFT JOIN transactions last_month 
ON this_month.cust_id = last_month.cust_id 
AND TIMESTAMPDIFF(MONTH, last_month.order_date, this_month.order_date) = 1
group by month(this_month.order_date);


SELECT month(last_month.order_date) month_num, count(last_month.cust_id) no_of_churn
FROM transactions last_month
LEFT JOIN transactions this_month
ON this_month.cust_id = last_month.cust_id 
AND TIMESTAMPDIFF(MONTH, last_month.order_date, this_month.order_date) = 1
where this_month.cust_id is null
group by month(last_month.order_date)