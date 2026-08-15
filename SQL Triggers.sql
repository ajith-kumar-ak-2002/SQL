-- ====================================================================
-- 📊 PRACTICE SCRIPT: SQL Triggers
-- ====================================================================

-- A Trigger is a database object that automatically runs (fires) 
-- in response to certain events (INSERT, UPDATE, or DELETE) on a table.

-- --------------------------------------------------------------------
-- 1. SETUP SAMPLE DATA & AUDIT TABLES
-- --------------------------------------------------------------------
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2),
    status VARCHAR(20) DEFAULT 'Active'
);

-- Audit table to log actions
CREATE TABLE emp_audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    action VARCHAR(50),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Salary history table to audit updates
CREATE TABLE salary_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- --------------------------------------------------------------------
-- 2. BEFORE INSERT TRIGGER
-- --------------------------------------------------------------------
-- Fires BEFORE a new row is inserted into the table.
-- Often used for data validation or normalization.
-- NEW refers to the incoming record/row.

DELIMITER //

CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    -- Force name to uppercase and validate salary
    SET NEW.emp_name = UPPER(NEW.emp_name);
    
    IF NEW.salary < 0 THEN
        SET NEW.salary = 0.00; -- Reset negative salary to 0
    END IF;
END //

DELIMITER ;

-- Test BEFORE INSERT trigger:
INSERT INTO employees (emp_name, salary) VALUES ('amit sharma', -5000.00);
SELECT * FROM employees; -- Name becomes 'AMIT SHARMA' and salary is set to 0.00


-- --------------------------------------------------------------------
-- 3. AFTER INSERT TRIGGER
-- --------------------------------------------------------------------
-- Fires AFTER a row has been successfully inserted.
-- Often used to update other tables or write to log tables.

DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    -- Insert a log record using NEW.emp_id
    INSERT INTO emp_audit_log (emp_id, action)
    VALUES (NEW.emp_id, 'Employee Inserted');
END //

DELIMITER ;

-- Test AFTER INSERT trigger:
INSERT INTO employees (emp_name, salary) VALUES ('Rahul Verma', 65000.00);
SELECT * FROM employees;
SELECT * FROM emp_audit_log; -- Logs the insert action automatically


-- --------------------------------------------------------------------
-- 4. AFTER UPDATE TRIGGER
-- --------------------------------------------------------------------
-- Fires AFTER an existing row is modified.
-- OLD refers to the row values before update.
-- NEW refers to the updated row values.

DELIMITER //

CREATE TRIGGER after_salary_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Check if salary has actually changed
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_history (emp_id, old_salary, new_salary)
        VALUES (NEW.emp_id, OLD.salary, NEW.salary);
    END IF;
END //

DELIMITER ;

-- Test AFTER UPDATE trigger:
UPDATE employees SET salary = 72000.00 WHERE emp_name = 'RAHUL VERMA';
SELECT * FROM salary_history; -- Records the old salary (65k) and new salary (72k)


-- --------------------------------------------------------------------
-- 5. BEFORE DELETE TRIGGER
-- --------------------------------------------------------------------
-- Fires BEFORE a row is deleted.
-- OLD refers to the row values being removed.
-- Often used to prevent deletions, or archive records.

DELIMITER //

CREATE TRIGGER before_employee_delete
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
    -- Prevent deletion of Active employees, force soft delete instead
    IF OLD.status = 'Active' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Cannot delete an active employee. Mark status as inactive first.';
    END IF;
END //

DELIMITER ;

-- Test BEFORE DELETE trigger (Should FAIL):
-- DELETE FROM employees WHERE emp_id = 2; -- Uncomment to test. Throws exception.

-- Make inactive, then try to delete:
UPDATE employees SET status = 'Inactive' WHERE emp_id = 2;
DELETE FROM employees WHERE emp_id = 2; -- Success!


-- --------------------------------------------------------------------
-- 6. MANAGING & DROPPING TRIGGERS
-- --------------------------------------------------------------------

-- List all triggers in the current database
SHOW TRIGGERS;

-- View the exact creation code for a trigger
SHOW CREATE TRIGGER after_salary_update;

-- Drop Triggers
DROP TRIGGER IF EXISTS before_employee_insert;
DROP TRIGGER IF EXISTS after_employee_insert;
DROP TRIGGER IF EXISTS after_salary_update;
DROP TRIGGER IF EXISTS before_employee_delete;

-- Clean up
DROP TABLE salary_history;
DROP TABLE emp_audit_log;
DROP TABLE employees;
