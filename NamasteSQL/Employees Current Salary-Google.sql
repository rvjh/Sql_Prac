WITH promotion_effects AS (
    SELECT 
        emp_id,
        EXP(SUM(LOG(1 + percent_increase / 100.0))) AS multiplier
    FROM promotions
    GROUP BY emp_id
)

SELECT 
    e.id,
    e.name,
    e.joining_salary AS initial_salary,
    ROUND(
        e.joining_salary * COALESCE(pe.multiplier, 1), 1
    ) AS current_salary
FROM employees e
LEFT JOIN promotion_effects pe
    ON e.id = pe.emp_id
ORDER BY e.id;
