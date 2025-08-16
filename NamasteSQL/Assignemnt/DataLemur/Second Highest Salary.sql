SELECT max(salary) AS second_highest_salary
FROM employee
where salary <
    (SELECT MAX(salary) FROM employee);