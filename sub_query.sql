USE employees;

SELECT e.first_name, e.last_name
FROM employees e
WHERE
    e.emp_no IN (
        SELECT dm.emp_no
        FROM dept_manager dm
    );

SELECT e.first_name, e.last_name
FROM employees e
WHERE
    EXISTS (
        SELECT *
        FROM dept_manager dm
        WHERE
            dm.emp_no = e.emp_no
    )
ORDER BY e.first_name;

SELECT a.*
FROM (
        SELECT
            e.emp_no AS employee_ID, MIN(de.dept_no) AS department_code, (
                SELECT emp_no
                FROM dept_manager
                WHERE
                    emp_no = '110022'
            ) AS manager_ID
        FROM employees e
            JOIN dept_emp de ON e.emp_no = de.emp_no
        WHERE
            e.emp_no <= '10020'
        GROUP BY
            e.emp_no
        ORDER BY e.emp_no
    ) AS a
UNION
SELECT b.*
FROM (
        SELECT
            e.emp_no AS employee_ID, MIN(de.dept_no) AS department_code, (
                SELECT emp_no
                FROM dept_manager
                WHERE
                    emp_no = '110039'
            ) AS manager_ID
        FROM employees e
            JOIN dept_emp de ON e.emp_no = de.emp_no
        WHERE
            e.emp_no > '10020'
        GROUP BY
            e.emp_no
        ORDER BY e.emp_no
        LIMIT 20
    ) AS b;

-- Making employee manager table
DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT(11) NOT NULL
);
-- since autocommit is on. This change is automatically saved

INSERT INTO
    emp_manager
SELECT u.*
FROM (
        SELECT a.*
        FROM (
                SELECT
                    e.emp_no AS employee_ID, MIN(de.dept_no) AS department_code, (
                        SELECT emp_no
                        FROM dept_manager
                        WHERE
                            emp_no = '110022'
                    ) AS manager_ID
                FROM employees e
                    JOIN dept_emp de ON e.emp_no = de.emp_no
                WHERE
                    e.emp_no <= '10020'
                GROUP BY
                    e.emp_no
                ORDER BY e.emp_no
            ) AS a
        UNION
        SELECT b.*
        FROM (
                SELECT
                    e.emp_no AS employee_ID, MIN(de.dept_no) AS department_code, (
                        SELECT emp_no
                        FROM dept_manager
                        WHERE
                            emp_no = '110039'
                    ) AS manager_ID
                FROM employees e
                    JOIN dept_emp de ON e.emp_no = de.emp_no
                WHERE
                    e.emp_no > '10020'
                GROUP BY
                    e.emp_no
                ORDER BY e.emp_no
                LIMIT 20
            ) AS b
        UNION
        SELECT c.*
        FROM (
                SELECT
                    e.emp_no AS employee_ID, MIN(de.dept_no) AS department_code, (
                        SELECT emp_no
                        FROM dept_manager
                        WHERE
                            emp_no = '110039'
                    ) AS manager_ID
                FROM employees e
                    JOIN dept_emp de ON e.emp_no = de.emp_no
                WHERE
                    e.emp_no = '110022'
                GROUP BY
                    e.emp_no
            ) AS c
        UNION
        SELECT d.*
        FROM (
                SELECT
                    e.emp_no AS employee_ID, MIN(de.dept_no) AS department_code, (
                        SELECT emp_no
                        FROM dept_manager
                        WHERE
                            emp_no = '110022'
                    ) AS manager_ID
                FROM employees e
                    JOIN dept_emp de ON e.emp_no = de.emp_no
                WHERE
                    e.emp_no = '110039'
                GROUP BY
                    e.emp_no
            ) AS d
    ) AS u;

SELECT * FROM emp_manager;