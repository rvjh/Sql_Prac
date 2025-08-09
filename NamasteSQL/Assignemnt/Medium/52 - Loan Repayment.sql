WITH payment_summary AS (
  SELECT 
    loan_id,
    SUM(amount_paid) AS total_paid,
    MAX(payment_date) AS last_payment_date
  FROM payments
  GROUP BY loan_id
)

SELECT 
  l.loan_id,
  l.loan_amount,
  l.due_date,
  CASE 
    WHEN ps.total_paid >= l.loan_amount THEN 1 
    ELSE 0 
  END AS fully_paid_flag,
  CASE 
    WHEN ps.total_paid >= l.loan_amount AND ps.last_payment_date <= l.due_date THEN 1 
    ELSE 0 
  END AS on_time_flag
FROM loans l
LEFT JOIN payment_summary ps 
  ON l.loan_id = ps.loan_id;