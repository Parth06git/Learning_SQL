USE employees;

SET autocommit = 0;

COMMIT;

SELECT * FROM salaries;

-- COUNT
SELECT COUNT(salary) FROM salaries;

SELECT COUNT(DISTINCT from_date) FROM salaries;

SELECT COUNT(*) FROM salaries;
-- * help us to take null value into account.

-- SUM
SELECT SUM(salary) FROM salaries;

-- MAX and MIN
SELECT MAX(salary), MIN(salary) FROM salaries;

-- AVG
SELECT AVG(salary) FROM salaries;

-- ROUND
SELECT ROUND(AVG(salary), 2) FROM salaries;

-- Making null values in department_dub
INSERT INTO department_dup (dept_no) VALUES ('d010');

INSERT INTO department_dup (dept_no) VALUES ('d011');

-- IFNULL
SELECT dept_no, IFNULL(
        dept_name, 'Department name not provided'
    ) as dept_name
FROM department_dup
ORDER BY dept_no;

-- COALESCE with 2 expression
SELECT dept_no, COALESCE(
        dept_name, 'Department name not provided'
    ) as dept_name
FROM department_dup
ORDER BY dept_no;

-- Adding a new column in department_dub table
ALTER TABLE department_dup ADD COLUMN dept_manager VARCHAR(40);

SELECT * FROM department_dup;

COMMIT;

-- COALESCE with more expression
SELECT
    dept_no,
    dept_name,
    COALESCE(
        dept_manager,
        dept_name,
        'N/A'
    ) as dept_manager
FROM department_dup
ORDER BY dept_no;