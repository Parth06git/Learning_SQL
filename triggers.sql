USE employees;

SET autocommit = 0;

COMMIT;

-- Before Trigger
DELIMITER $$

CREATE TRIGGER before_salary_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN
    IF NEW.salary < 0 
    THEN
        SET NEW.salary = 0;
    END IF;
END $$

DELIMITER;

SELECT * FROM salaries WHERE emp_no = 10001;

INSERT INTO
    salaries
VALUES (
        10001,
        -85000,
        '2010-06-12',
        '9999-12-31'
    );

ROLLBACK;

-- After Trigger
DELIMITER $$

CREATE TRIGGER after_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN

DECLARE v_curr_salary int;

SELECT MAX(salary) INTO v_curr_salary
FROM salaries
WHERE
    emp_no = NEW.emp_no;

IF v_curr_salary IS NOT NULL 
THEN
UPDATE salaries
SET
    to_date = SYSDATE()
WHERE
    emp_no = NEW.emp_no
    AND to_date = NEW.to_date;

INSERT INTO
    salaries
VALUES (
        NEW.emp_no,
        v_curr_salary + 20000,
        NEW.from_date,
        NEW.to_date
    );

END IF;
END $$

DELIMITER;

INSERT INTO
    dept_manager
VALUES (
        111534,
        'd009',
        DATE_FORMAT(SYSDATE(), '%y-%m-%d'),
        '9999-01-01'
    );

SELECT * FROM dept_manager WHERE emp_no = 111534;

SELECT * FROM salaries WHERE emp_no = 111534;