select * from namaste_python;


-- Find the words which are repeating more than once considering all the rows
SELECT word, COUNT(*) AS cnt_of_word
FROM (
    SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(content, ' ', n.n), ' ', -1) AS word
    FROM namaste_python
    JOIN (
        SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
        UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
    ) AS n ON LENGTH(content) - LENGTH(REPLACE(content, ' ', '')) >= n.n - 1
) AS words
GROUP BY word
HAVING COUNT(*) > 1
ORDER BY cnt_of_word DESC;