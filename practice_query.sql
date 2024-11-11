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

-- Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.

SELECT *
FROM dept_manager
WHERE
    emp_no IN (
        SELECT emp_no
        FROM employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01'
    );

-- Select the entire information for all employees whose job title is “Assistant Engineer”.
SELECT *
FROM employees e
WHERE
    EXISTS (
        SELECT *
        FROM titles ti
        WHERE
            e.emp_no = ti.emp_no
            AND ti.title = 'Assistant Engineer'
    );

-- Execute a query containing a self-join of the emp_manager table on the employee and manager numbers, using the aliases e1 and e2. In the field list, designate all columns in the order they appear in the e2 table.

SELECT e2.*
FROM
    emp_manager e1
    JOIN emp_manager e2 ON e1.emp_no = e2.manager_no
ORDER BY e2.manager_no;

-- Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent.

CREATE OR REPLACE VIEW v_manager_avg_salary AS
SELECT ROUND(AVG(s.salary), 2) AS Average_Salary
FROM salaries s
    JOIN dept_manager dm ON s.emp_no = dm.emp_no;

SELECT * FROM v_manager_avg_salary;