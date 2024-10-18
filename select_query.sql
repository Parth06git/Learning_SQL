USE employees;
-- while using in workbench to know which db is going to use to run the query.

SELECT first_name, last_name FROM employees;

-- Where clause

SELECT * FROM employees WHERE first_name = 'Denis';

-- AND Operator
SELECT *
FROM employees
WHERE
    first_name = 'Denis'
    AND gender = 'M';

-- OR Operator
SELECT *
FROM employees
WHERE
    first_name = 'Denis'
    OR first_name = 'Elvis';

-- Operator Precedence
SELECT *
FROM employees
WHERE
    last_name = 'Denis'
    AND (
        gender = 'M'
        OR gender = 'F'
    );

-- IN and NOT IN Operator
SELECT *
FROM employees
WHERE
    first_name IN ('Cathie', 'Mark', 'Nathan');

-- LIKE and NOT LIKE Operator
SELECT * FROM employees WHERE first_name LIKE('%ar');
-- % denote unspecified number of character

SELECT *
FROM employees
WHERE
    hire_date BETWEEN '1990-01-01' AND '2000-01-01';

-- IS NULL and IS NOT NULL
SELECT * FROM employees WHERE first_name IS NULL;

-- other operations
SELECT * FROM employees WHERE first_name <> 'Mark';

SELECT first_name FROM employees WHERE first_name != 'Mark';

-- Distinct select (retrive only distinct record)
SELECT DISTINCT gender FROM employees;

-- Aggregate function
SELECT COUNT(emp_no) FROM employees;

SELECT COUNT(DISTINCT first_name) FROM employees;

-- ORDER BY
SELECT * FROM employees ORDER BY first_name;

SELECT * FROM employees ORDER BY emp_no DESC;

SELECT * FROM employees ORDER BY first_name, last_name ASC;

-- GROUP BY
SELECT first_name, COUNT(first_name) AS names_count
FROM employees
GROUP BY
    first_name
ORDER BY names_count;

-- HAVING
SELECT first_name, COUNT(first_name) AS names_count
FROM employees
GROUP BY
    first_name
HAVING
    names_count > 250;

-- WHERE and HAVING
SELECT first_name, COUNT(first_name) AS names_count
FROM employees
WHERE
    hire_date > '1999-01-01'
GROUP BY
    first_name
HAVING
    names_count < 200
ORDER BY first_name;

-- LIMIT
SELECT salary FROM salaries ORDER BY salary DESC LIMIT 5;