USE employees;

SET autocommit = 0;

COMMIT;

-- For pratice SQL joins changes in department_dup table
DROP TABLE department_dup;

CREATE TABLE department_dup (
    dept_no CHAR(4),
    dept_name CHAR(40)
);

INSERT INTO department_dup SELECT * FROM departments;

COMMIT;

INSERT INTO department_dup (dept_name) VALUES ('Public Relations');

DELETE FROM department_dup WHERE dept_no = 'd002';

INSERT INTO department_dup (dept_no) VALUES ('d010');

INSERT INTO department_dup (dept_no) VALUES ('d011');

SELECT * FROM department_dup ORDER BY dept_no;

COMMIT;

-- For pratice SQL joins we created a dept_manager_dup

CREATE TABLE dept_manager_dup (
    emp_no int(11) NOT NULL,
    dept_no char(4) NULL,
    from_date date NOT NULL,
    to_date date NULL
);

INSERT INTO dept_manager_dup SELECT * FROM dept_manager;

INSERT INTO
    dept_manager_dup (emp_no, from_date)
VALUES (999904, '2017-01-01'),
    (999905, '2017-01-01'),
    (999906, '2017-01-01'),
    (999907, '2017-01-01');

DELETE FROM dept_manager_dup WHERE dept_no = 'd001';

SELECT * FROM dept_manager_dup;

COMMIT;
