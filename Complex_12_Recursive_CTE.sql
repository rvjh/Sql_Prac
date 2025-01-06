select * from sales_1;

-- anchor row

select min(period_start) dates, max(period_end) max_date from sales_1;


WITH RECURSIVE r_cte AS (
    SELECT MIN(period_start) AS dates, MAX(period_end) AS max_date
    FROM sales_1
    UNION ALL
    SELECT DATE_ADD(dates, INTERVAL 1 DAY), max_date
    FROM r_cte 
    WHERE dates < max_date
)
SELECT product_id, YEAR(dates) AS report_year, SUM(average_daily_sales) AS total_amt 
FROM r_cte
INNER JOIN sales_1 ON dates BETWEEN period_start AND period_end
GROUP BY product_id, YEAR(dates)
ORDER BY product_id;





