-- ====================================================================
-- 📊 PRACTICE SCRIPT: SQL Transactions & Foreign Key Constraints
-- ====================================================================

-- --------------------------------------------------------------------
-- 1. TRANSACTION CONTROL DEMONSTRATION
-- --------------------------------------------------------------------
-- By default, MySQL runs in Autocommit mode (changes are saved instantly).
-- Let's test explicit transactions using START TRANSACTION, COMMIT, and ROLLBACK.

-- Step A: Set up a temporary practice table
CREATE TABLE bank_accounts (
    account_id INT PRIMARY KEY,
    holder_name VARCHAR(50),
    balance DECIMAL(10, 2)
);

INSERT INTO bank_accounts VALUES 
(1, 'Alice', 1000.00),
(2, 'Bob', 1500.00);

-- Step B: Rollback Demo (Undo changes)
START TRANSACTION;

-- Deduct from Alice, add to Bob
UPDATE bank_accounts SET balance = balance - 100.00 WHERE account_id = 1;
UPDATE bank_accounts SET balance = balance + 100.00 WHERE account_id = 2;

-- Check temporary state in this session (Alice has 900, Bob has 1600)
SELECT * FROM bank_accounts;

-- Oops, rollback the changes!
ROLLBACK;

-- Verify changes were undone (Alice is back to 1000, Bob to 1500)
SELECT * FROM bank_accounts;

-- Step C: Commit Demo (Save changes permanently)
START TRANSACTION;

UPDATE bank_accounts SET balance = balance - 200.00 WHERE account_id = 1;
UPDATE bank_accounts SET balance = balance + 200.00 WHERE account_id = 2;

-- Commit the transaction
COMMIT;

-- Verify changes are permanently saved
SELECT * FROM bank_accounts;

-- Clean up
DROP TABLE bank_accounts;


-- --------------------------------------------------------------------
-- 2. FOREIGN KEYS & REFERENTIAL INTEGRITY DEMONSTRATION
-- --------------------------------------------------------------------

-- Step A: Create Parent Table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Step B: Create Child Table with Default Foreign Key Constraint
-- This uses the default referential behavior (ON DELETE NO ACTION / RESTRICT)
CREATE TABLE employees_fk (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT,
    -- Default foreign key setup:
    CONSTRAINT fk_dept 
        FOREIGN KEY (dept_id) 
        REFERENCES departments(dept_id)
);

-- Insert Sample Data
INSERT INTO departments (dept_id, dept_name) VALUES 
(10, 'HR'),
(20, 'Engineering'),
(30, 'Sales');

INSERT INTO employees_fk (emp_id, emp_name, dept_id) VALUES 
(101, 'John Doe', 10),
(102, 'Jane Smith', 20),
(103, 'Bob Johnson', 20);

-- --------------------------------------------------------------------
-- 3. DEFAULT FOREIGN KEY PROTECTION
-- --------------------------------------------------------------------
-- Try to delete a parent department record that is currently referenced by employees.
-- This will FAIL due to Foreign Key Protection (RESTRICT behavior).
DELETE FROM departments WHERE dept_id = 20; 

-- --------------------------------------------------------------------
-- 4. DROPPING AN EXISTING FOREIGN KEY CONSTRAINT
-- --------------------------------------------------------------------
-- To alter behavior, we must first drop the existing constraint.
ALTER TABLE employees_fk 
DROP FOREIGN KEY fk_dept;

-- --------------------------------------------------------------------
-- 5. ADDING A NEW FOREIGN KEY CONSTRAINT WITH CASCADE
-- --------------------------------------------------------------------
-- Let's add a new constraint that will automatically delete employees 
-- when their department is deleted.
ALTER TABLE employees_fk 
ADD CONSTRAINT fk_dept_cascade 
    FOREIGN KEY (dept_id) 
    REFERENCES departments(dept_id) 
    ON DELETE CASCADE;

-- Test the CASCADE behavior by deleting department 20 (Engineering)
DELETE FROM departments WHERE dept_id = 20;

-- Verify results: Engineering department is gone, and 
-- Jane Smith (102) & Bob Johnson (103) are automatically deleted!
SELECT * FROM departments;
SELECT * FROM employees_fk;

-- --------------------------------------------------------------------
-- 6. ALTERING FOREIGN KEY TO ON DELETE SET NULL
-- --------------------------------------------------------------------
-- First drop the cascade constraint:
ALTER TABLE employees_fk 
DROP FOREIGN KEY fk_dept_cascade;

-- Now add foreign key constraint with ON DELETE SET NULL:
-- When a department is deleted, the employee's dept_id becomes NULL instead of deleting the employee.
ALTER TABLE employees_fk 
ADD CONSTRAINT fk_dept_setnull 
    FOREIGN KEY (dept_id) 
    REFERENCES departments(dept_id) 
    ON DELETE SET NULL;

-- Test the SET NULL behavior
-- First, re-insert engineering department and an employee
INSERT INTO departments VALUES (20, 'Engineering');
INSERT INTO employees_fk VALUES (104, 'David Miller', 20);

-- Delete department 20
DELETE FROM departments WHERE dept_id = 20;

-- Verify results: David Miller (104) still exists, but his dept_id has been set to NULL!
SELECT * FROM employees_fk;

-- Clean up
DROP TABLE employees_fk;
DROP TABLE departments;
