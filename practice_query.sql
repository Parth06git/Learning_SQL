USE employees;

SET autocommit = 0;

COMMIT;

-- Use to practice some quey from course

-- Get dept_name and average_salary(for their manager)
SELECT d.dept_name, ROUND(AVG(s.salary), 2) AS avg_manager_salary
FROM
    departments d
    JOIN dept_manager dm ON d.dept_no = dm.dept_no
    JOIN salaries s ON dm.emp_no = s.emp_no
GROUP BY
    d.dept_no
HAVING
    avg_manager_salary > 60000
ORDER BY avg_manager_salary;

-- Average salary for each job title
SELECT ti.title, ROUND(AVG(s.salary), 2) AS avg_salary
FROM titles ti
    JOIN salaries s on ti.emp_no = s.emp_no
GROUP BY
    ti.title
HAVING
    avg_salary < 75000
ORDER BY avg_salary DESC;