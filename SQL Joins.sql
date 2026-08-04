-- ====================================================================
-- 📊 PRACTICE SCRIPT: SQL Joins (INNER, LEFT, RIGHT)
-- ====================================================================

-- --------------------------------------------------------------------
-- 1. SETUP TABLES & SAMPLE DATA
-- --------------------------------------------------------------------

-- Create Departments Table (Parent Table)
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Create Employees Table (Child Table)
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2),
    dept_id INT -- Can be NULL to demonstrate Outer Joins
);

-- Insert Sample Departments
-- Note: 'Marketing' has no employees assigned to it yet.
INSERT INTO departments (dept_id, dept_name) VALUES
(10, 'HR'),
(20, 'Engineering'),
(30, 'Sales'),
(40, 'Marketing');

-- Insert Sample Employees
-- Note: 'Kunal Sen' has NULL dept_id (no department assigned).
INSERT INTO employees (emp_id, emp_name, salary, dept_id) VALUES
(101, 'Rohit Sharma', 45000.00, 10),
(102, 'Priya Reddy', 52000.00, 20),
(103, 'Arjun Kumar', 68000.00, 20),
(104, 'Sneha Patel', 49000.00, 30),
(105, 'Kunal Sen', 35000.00, NULL);


-- --------------------------------------------------------------------
-- 2. INNER JOIN
-- --------------------------------------------------------------------
-- Returns records that have matching values in both tables.
-- (Will exclude 'Kunal Sen' because dept_id is NULL, and 'Marketing' because no employee is in it).
SELECT 
    e.emp_id, 
    e.emp_name, 
    e.salary, 
    d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;


-- --------------------------------------------------------------------
-- 3. LEFT JOIN (or LEFT OUTER JOIN)
-- --------------------------------------------------------------------
-- Returns all records from the left table (employees), and the matched records from the right table (departments).
-- (Will include 'Kunal Sen' with NULL department details).
SELECT 
    e.emp_id, 
    e.emp_name, 
    e.salary, 
    d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;


-- --------------------------------------------------------------------
-- 4. RIGHT JOIN (or RIGHT OUTER JOIN)
-- --------------------------------------------------------------------
-- Returns all records from the right table (departments), and the matched records from the left table (employees).
-- (Will include 'Marketing' with NULL employee details).
SELECT 
    e.emp_id, 
    e.emp_name, 
    e.salary, 
    d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;


-- --------------------------------------------------------------------
-- 5. JOINS WITH WHERE CONDITIONS
-- --------------------------------------------------------------------

-- A. INNER JOIN with a WHERE filter (e.g., salary greater than 50,000)
SELECT 
    e.emp_id, 
    e.emp_name, 
    e.salary, 
    d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary > 50000;

-- B. LEFT JOIN identifying unmatched records (finding employees without a department)
SELECT 
    e.emp_id, 
    e.emp_name, 
    e.salary
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE e.dept_id IS NULL;

-- C. RIGHT JOIN identifying unmatched records (finding departments with no employees)
SELECT 
    d.dept_id, 
    d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;


-- --------------------------------------------------------------------
-- 6. CLEAN UP
-- --------------------------------------------------------------------
DROP TABLE employees;
DROP TABLE departments;
