WITH ranked_opens AS (
  SELECT 
    ticker,
    TO_CHAR(date, 'Mon-YYYY') AS month_year,
    open,
    ROW_NUMBER() OVER (PARTITION BY ticker ORDER BY open DESC) AS rn_high,
    ROW_NUMBER() OVER (PARTITION BY ticker ORDER BY open ASC) AS rn_low
  FROM stock_prices
  WHERE ticker IN ('AAPL', 'AMZN', 'GOOG', 'META', 'MSFT', 'NFLX')
)

SELECT 
  ticker,
  MAX(CASE WHEN rn_high = 1 THEN month_year END) AS highest_mth,
  MAX(CASE WHEN rn_high = 1 THEN open END) AS highest_open,
  MAX(CASE WHEN rn_low = 1 THEN month_year END) AS lowest_mth,
  MAX(CASE WHEN rn_low = 1 THEN open END) AS lowest_open
FROM ranked_opens
GROUP BY ticker
ORDER BY ticker;
