select * from phone_numbers;

--

-- Sample MySQL-compatible query


WITH RECURSIVE cte AS (
  SELECT 
    num,
    CASE WHEN INSTR(num, '-') = 0 THEN num
         ELSE SUBSTRING_INDEX(num, '-', -1)
    END AS new_num
  FROM phone_numbers
),
digit_cte AS (
  SELECT 
    num,
    new_num,
    SUBSTRING(new_num, 1, 1) AS digit,
    1 AS pos
  FROM cte
  WHERE LENGTH(new_num) > 0

  UNION ALL

  SELECT 
    num,
    new_num,
    SUBSTRING(new_num, pos + 1, 1),
    pos + 1
  FROM digit_cte
  WHERE pos + 1 <= LENGTH(new_num)
)
SELECT 
  num,
  new_num,
  COUNT(*) AS no_of_digits,
  COUNT(DISTINCT digit) AS digit_distinct
FROM digit_cte
GROUP BY num, new_num
HAVING COUNT(*) = COUNT(DISTINCT digit);
