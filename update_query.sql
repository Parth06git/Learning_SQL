-- By default, MySQL starts the session
-- for each new connection with
-- autocommit enabled,

USE employees;

SET autocommit = 0;
-- to disable autocommit.
SELECT * FROM employees ORDER BY emp_no DESC;

-- UPDATE
UPDATE employees
SET
    last_name = 'Bajaj',
    hire_date = '2024-11-01'
WHERE
    emp_no = 9999901;

SELECT * FROM employees WHERE emp_no = 9999901;

-- COMMIT and ROLLBACK
SELECT * FROM department_dup ORDER BY dept_no;

COMMIT;

UPDATE department_dup SET dept_name = 'Quality Control';

ROLLBACK;