select * from transactions;

-- month customer_retaintion
-- jan 		0
-- Feb      2

SELECT 
    MONTH(this_month.order_date) AS month_name, 
    COUNT(DISTINCT last_month.cust_id) AS retain_customer  
FROM transactions this_month  
left JOIN transactions last_month  
ON this_month.cust_id = last_month.cust_id 
AND MONTH(this_month.order_date) - MONTH(last_month.order_date) = 1  
GROUP BY MONTH(this_month.order_date);