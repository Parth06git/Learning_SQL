USE employees;

SELECT
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN "Male"
        WHEN gender = "F" THEN 'Female'
        ELSE 'No Data'
    END AS gender
FROM employees
LIMIT 5;

SELECT
    emp_no,
    first_name,
    last_name,
    IF(
        gender = 'M',
        'Male',
        'Female'
    ) AS gender
FROM employees
LIMIT 5;