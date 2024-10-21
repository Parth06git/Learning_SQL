USE employees;

SET autocommit = 0;

INSERT INTO
    titles (emp_no, title, from_date)
VALUES (
        9999901,
        'Team Leader',
        '2024-11-01'
    );

COMMIT;

SELECT * FROM titles WHERE emp_no = 9999901;

DELETE FROM employees WHERE emp_no = 9999901;

SELECT * FROM employees WHERE emp_no = 9999901;

ROLLBACK;