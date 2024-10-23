USE employees;

SELECT * FROM dept_manager_dup ORDER BY dept_no;

SELECT * FROM department_dup ORDER BY dept_no;

-- INNER JOIN
SELECT t1.dept_no, t2.emp_no, t1.dept_name
FROM
    department_dup t1
    INNER JOIN dept_manager_dup t2 ON t1.dept_no = t2.dept_no
ORDER BY t1.dept_no;

SELECT t1.emp_no, t1.from_date, t2.dept_name
FROM
    dept_emp t1
    JOIN department_dup t2 ON t1.dept_no = t2.dept_no;
-- INNER JOIN == JOIN

-- Duplicate Records
INSERT INTO
    dept_manager_dup
VALUES (
        110085,
        'd002',
        '1985-01-01',
        '1989-12-17'
    );

SELECT * FROM dept_manager_dup WHERE emp_no = 110085;

INSERT INTO department_dup VALUES ('d009', 'Customer Service');

-- if we apply same inner join query again then we will get more result due to duplicate records
SELECT t1.dept_no, t1.emp_no, t2.dept_name
FROM
    dept_manager_dup t1
    INNER JOIN department_dup t2 ON t1.dept_no = t2.dept_no
GROUP BY
    t1.emp_no,
    t1.dept_no,
    t2.dept_name
ORDER BY t1.dept_no;

-- removing duplicates
SET autocommit = 0;

COMMIT;

SELECT * FROM department_dup ORDER BY dept_no;

DELETE FROM department_dup WHERE dept_no = 'd009';

INSERT INTO department_dup VALUES ('d009', 'Customer Service');

SELECT * FROM dept_manager_dup WHERE emp_no = 110085;

DELETE FROM dept_manager_dup WHERE emp_no = 110085;

INSERT INTO
    dept_manager_dup
VALUES (
        110085,
        'd002',
        '1985-01-01',
        '1989-12-17'
    );

COMMIT;

-- LEFT JOIN
SELECT t1.dept_no, t1.emp_no, t2.dept_name
FROM
    dept_manager_dup t1
    LEFT JOIN department_dup t2 ON t1.dept_no = t2.dept_no
ORDER BY t1.dept_no;
-- LEFT JOIN == LEFT OUTER JOIN

-- Getting outer part of left not including inner part
SELECT t1.dept_no, t1.emp_no, t2.dept_name
FROM
    dept_manager_dup t1
    LEFT JOIN department_dup t2 ON t1.dept_no = t2.dept_no
WHERE
    t2.dept_name IS NULL
ORDER BY t1.dept_no;

-- RIGHT JOIN
-- RIGHT OUTER JOIN == RIGHT JOIN
SELECT t1.dept_no, t1.emp_no, t2.dept_name
FROM
    dept_manager_dup t1
    RIGHT JOIN department_dup t2 ON t1.dept_no = t2.dept_no
ORDER BY t1.dept_no;

SELECT t1.dept_no, t1.emp_no, t2.dept_name
FROM
    dept_manager_dup t1
    RIGHT JOIN department_dup t2 ON t1.dept_no = t2.dept_no
WHERE
    t1.dept_no IS NULL
ORDER BY t1.dept_no;

-- JOIN and WHERE
SELECT e.emp_no, e.first_name, e.last_name, s.salary
FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 145000
ORDER BY e.emp_no;

-- CROSS JOIN
SELECT e.emp_no, d.dept_no, d.dept_name
FROM dept_manager e
    CROSS JOIN departments d
ORDER BY e.emp_no, d.dept_no;

SELECT e.emp_no, d.dept_no, d.dept_name
FROM dept_manager e
    JOIN departments d
ORDER BY e.emp_no, d.dept_no;
-- Not good practice to use JOIN without ON. Better to use CROSS JOIN

-- Aggregate function
SELECT e.gender, AVG(s.salary) AS avg_salary
FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY
    gender;

-- Joining more than 2 tables
SELECT e.first_name, e.last_name, e.hire_date, dm.from_date, d.dept_name
FROM
    employees e
    JOIN dept_manager dm ON e.emp_no = dm.emp_no
    JOIN departments d ON dm.dept_no = d.dept_no
ORDER BY d.dept_no;

SELECT e.first_name, e.last_name, e.hire_date, ti.title, d.dept_name
FROM
    employees e
    JOIN titles ti on e.emp_no = ti.emp_no
    JOIN dept_emp de on ti.emp_no = de.emp_no
    JOIN departments d on de.dept_no = d.dept_no
WHERE
    ti.title = 'Senior Engineer';

-- create employees duplicate and adding 20 entries
CREATE TABLE IF NOT EXISTS employees_dup (
    emp_no INT(11),
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender ENUM('M', 'F'),
    hire_date DATE
);

INSERT INTO employees_dup SELECT * FROM employees LIMIT 20;

INSERT INTO
    employees_dup
VALUES (
        10001,
        '1953-09-02',
        'Georgi',
        'Facello',
        'M',
        '1986-06-26'
    );

SELECT * FROM employees_dup ORDER BY emp_no;

-- UNION ALL
SELECT
    emp_no,
    first_name,
    NULL AS dept_no,
    NULL AS from_date
FROM employees_dup
WHERE
    emp_no = 10001
UNION ALL
SELECT
    NULL AS emp_no,
    NULL AS first_name,
    dept_no,
    from_date
FROM dept_manager;

-- UNOIN
SELECT
    emp_no,
    first_name,
    NULL AS dept_no,
    NULL AS from_date
FROM employees_dup
WHERE
    emp_no = 10001
UNION
SELECT
    NULL AS emp_no,
    NULL AS first_name,
    dept_no,
    from_date
FROM dept_manager;