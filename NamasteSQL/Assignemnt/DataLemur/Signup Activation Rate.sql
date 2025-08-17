WITH confirmed_emails AS (
  SELECT DISTINCT email_id
  FROM texts
  WHERE signup_action = 'Confirmed'
)

SELECT 
  ROUND(
    COUNT(DISTINCT confirmed_emails.email_id) * 1.0 
    / NULLIF(COUNT(DISTINCT emails.email_id), 0), 
    2
  ) AS confirm_rate
FROM emails
LEFT JOIN confirmed_emails 
  ON emails.email_id = confirmed_emails.email_id;

