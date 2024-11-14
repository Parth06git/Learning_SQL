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

-- Create a procedure that will provide the average salary of all employees. Then, call the procedure.
DROP PROCEDURE IF EXISTS average_salary;

DELIMITER $$

CREATE PROCEDURE average_salary()
BEGIN
SELECT ROUND(AVG(salary), 2) AS avg_salary FROM salaries;
END $$

DELIMITER;

CALL average_salary ();

-- Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and returns the salary from the newest contract of that employee.

DELIMITER $$

CREATE FUNCTION emp_info (
    p_first_name VARCHAR(255),
    p_last_name VARCHAR(255)
) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
DECLARE v_from_date DATE;
DECLARE v_salary DECIMAL(10,2);

SELECT MAX(s.from_date) INTO v_from_date
FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
    AND e.last_name = p_last_name;

SELECT s.salary INTO v_salary
FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
WHERE
    s.from_date = v_from_date
    AND e.first_name = p_first_name
    AND e.last_name = p_last_name;

RETURN v_salary;
END $$

DELIMITER;

SELECT emp_info ('Aruna', 'Journel') AS current_salary;