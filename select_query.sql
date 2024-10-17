USE employees; -- while using in workbench to know which db is going to use to run the query.

SELECT 
    first_name, last_name
FROM
    employees;

-- Where clause

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';

-- AND Operator
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';

-- OR Operator
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        OR first_name = 'Elvis';

-- Operator Precedence
SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis'
        AND (gender = 'M' OR gender = 'F');

-- IN and NOT IN Operator
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Cathie' , 'Mark', 'Nathan');

-- LIKE and NOT LIKE Operator
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%ar');-- % denote unspecified number of character 

SELECT 
    *
FROM
    employees
WHERE
    hire_date BETWEEN '1990-01-01' AND '2000-01-01';

-- IS NULL and IS NOT NULL
SELECT 
    *
FROM
    employees
WHERE
    first_name IS NULL;

-- other operations
SELECT 
    *
FROM
    employees
WHERE
    first_name <> 'Mark';

SELECT 
    first_name
FROM
    employees
WHERE
    first_name != 'Mark';