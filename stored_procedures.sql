USE employees;

DROP PROCEDURE IF EXISTS select_employees;

-- Basic procedure
DELIMITER $$

CREATE PROCEDURE select_employees() 
BEGIN 
SELECT * FROM employees LIMIT 100; 
END $$

DELIMITER;

-- Calling procedures
CALL select_employees ();

-- procedure with input parameter
DROP PROCEDURE IF EXISTS emp_salary;

DELIMITER $$

CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
SELECT e.first_name, e.last_name, AVG(s.salary)
FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no
GROUP BY
    e.emp_no;
END $$

DELIMITER;

CALL emp_salary (11300);

-- Out parameter
DROP PROCEDURE IF EXISTS emp_salary_out;

DELIMITER $$

CREATE PROCEDURE emp_salary_out(IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL(10,2))
BEGIN
SELECT AVG(s.salary) INTO p_avg_salary
FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no
GROUP BY
    e.emp_no;
END $$

DELIMITER;

-- Variable
SET @avg_salary = NULL;

CALL emp_salary_out (11300, @avg_salary);

SELECT @avg_salary;