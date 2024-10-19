USE employees;

SELECT * FROM employees ORDER BY emp_no DESC LIMIT 5;

INSERT INTO
    employees (
        emp_no,
        birth_date,
        first_name,
        last_name,
        gender,
        hire_date
    )
VALUES (
        9999901,
        '2004-12-06',
        'Parth',
        'Trivedi',
        'M',
        '2024-11-04'
    );

SELECT * FROM departments ORDER BY dept_no;

CREATE TABLE department_dup (
    dept_no CHAR(4) NOT NULL PRIMARY KEY,
    dept_name CHAR(40) NOT NULL
);

-- Adding some data from another table
INSERT INTO department_dup SELECT * FROM departments;

SELECT * FROM department_dup ORDER BY dept_no;