-- USE webtech;

-- CREATE TABLE emloyees (
-- 	employee_id INT, 
--     first_name VARCHAR(50),
--     hire_date DATE
-- );

-- select * from emloyees

-- RENAME TABLE emloyees to employees

-- INSERT INTO employeesemloyees
-- VALUES (1, "Jay", "2023-12-12");

UPDATE employees
SET first_name = "Javokhir"
WHERE employee_id = 6;

SELECT * FROM employees