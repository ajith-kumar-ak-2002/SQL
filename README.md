# 📊 SQL Learning Journey & Reference Guide

Welcome to my **SQL (Structured Query Language)** repository! This space serves as a comprehensive log and reference guide for everything I have learned during my SQL course. 

Inside, you will find detailed explanations, command syntaxes, and conceptual write-ups of core database principles.

---

## 🔍 Table of Contents
1. [What is a Database?](#1-what-is-a-database)
2. [Types of SQL Commands](#2-types-of-sql-commands)
3. [SQL Datatypes](#3-sql-datatypes)
4. [SQL Constraints & The Primary Key](#4-sql-constraints--the-primary-key)
5. [Database Administration Commands](#5-database-administration-commands)
6. [Table Administration Commands](#6-table-administration-commands)
7. [Data Manipulation: INSERT, UPDATE, and DELETE](#7-data-manipulation-insert-update-and-delete)
8. [Table with Constraints Example](#8-table-with-constraints-example)
9. [Querying Data: DQL SELECT Statements](#9-querying-data-dql-select-statements)
10. [Transaction Control & Autocommit](#10-transaction-control--autocommit)
11. [SQL Functions: Single-Row & Aggregate](#11-sql-functions-single-row--aggregate)
12. [Foreign Key Constraints & Referential Integrity](#12-foreign-key-constraints--referential-integrity)
13. [SQL Joins: INNER, LEFT, and RIGHT](#13-sql-joins-inner-left-and-right)
14. [Self Join](#14-self-join)
15. [Grouping Data: GROUP BY & HAVING](#15-grouping-data-group-by--having)
16. [Set Operations: UNION & UNION ALL](#16-set-operations-union--union-all)
17. [SQL Views](#17-sql-views)

---

## 1. What is a Database?
A **Database** is a systematic and organized collection of data stored electronically in a computer system. 
* **DBMS (Database Management System):** Software used to manage, store, retrieve, and define data in a database.
* **RDBMS (Relational Database Management System):** A type of DBMS that stores data in a structured format using **tables** (rows and columns). Relationships are established between tables. Examples include MySQL, PostgreSQL, MS SQL Server, and SQLite.

---

## 2. Types of SQL Commands
SQL commands are categorized based on their functionality:

| Category | Description | Key Commands |
| :--- | :--- | :--- |
| **DDL** (Data Definition Language) | Defines or alters the database structure/schema. | `CREATE`, `DROP`, `ALTER`, `TRUNCATE` |
| **DML** (Data Manipulation Language) | Manages and manipulates data within existing structures. | `INSERT`, `UPDATE`, `DELETE` |
| **DQL** (Data Query Language) | Retrieves data from the database. | `SELECT` |
| **DCL** (Data Control Language) | Controls access permissions and privileges. | `GRANT`, `REVOKE` |
| **TCL** (Transaction Control Language) | Manages transactions within the database. | `COMMIT`, `ROLLBACK`, `SAVEPOINT` |

---

## 3. SQL Datatypes
Datatypes define the kind of value that can be stored in a column. Common categories include:

### 📝 String / Character Types
* `CHAR(size)`: Fixed-length character string.
* `VARCHAR(size)`: Variable-length character string.
* `TEXT`: Long-form text block.

### 🔢 Numeric Types
* `INT` / `INTEGER`: Standard whole numbers.
* `DECIMAL(precision, scale)` / `NUMERIC`: Exact numeric values (e.g., currency).
* `FLOAT` / `DOUBLE`: Approximate decimal values.

### 📅 Date and Time Types
* `DATE`: Format `YYYY-MM-DD`.
* `TIME`: Format `HH:MM:SS`.
* `DATETIME` / `TIMESTAMP`: Format `YYYY-MM-DD HH:MM:SS`.

---

## 4. SQL Constraints & The Primary Key
Constraints are rules applied to columns to limit the type of data that can go into a table. This ensures the accuracy and reliability of the data (data integrity).

* **`NOT NULL`**: Ensures that a column cannot have a `NULL` value.
* **`UNIQUE`**: Ensures that all values in a column are distinct.
* **`PRIMARY KEY`**: Uniquely identifies each row in a table. It is a combination of `NOT NULL` and `UNIQUE`.
* **`FOREIGN KEY`**: Prevents actions that would destroy links between tables. Links a column to a primary key in another table.
* **`CHECK`**: Ensures that the values in a column satisfy a specific condition.
* **`DEFAULT`**: Sets a default value for a column if no value is specified.

### 🔑 Why is a Primary Key Important?
The **Primary Key** is one of the most critical concepts in relational databases for the following reasons:
1. **Unique Identification:** It ensures that every record/row in the table can be uniquely identified. No two rows can have the same primary key value.
2. **Prevents Duplicate Data:** By enforcing uniqueness, it prevents accidental insertion of duplicate records (e.g., two customers with the exact same customer ID).
3. **Establishes Relationships:** It is used as a reference point for **Foreign Keys** in other tables to create connections and relationships between tables.
4. **Faster Data Retrieval:** Databases automatically create an index on the primary key, which drastically speeds up searches, queries, and lookups.
5. **Data Integrity:** It ensures that database records remain reliable, organized, and logically structured.

---

## 5. Database Administration Commands

These commands manage databases at a high level.

### A. Create a Database
Creates a new database container.
```sql
CREATE DATABASE database_name;
```

### B. Show Databases
Lists all available databases in the server.
```sql
SHOW DATABASES;
```

### C. Use a Database
Selects a database to perform subsequent table operations.
```sql
USE database_name;
```

### D. Delete (Drop) a Database
Deletes a database and all its tables/data permanently.
```sql
DROP DATABASE database_name;
```

---

## 6. Table Administration Commands

Tables are the core structures that hold data.

### A. Create a Table
Creates a new table with defined columns, datatypes, and constraints.
```sql
CREATE TABLE table_name (
    column1 datatype constraint,
    column2 datatype constraint,
    column3 datatype,
    PRIMARY KEY (column1)
);
```

### B. Show Tables
Lists all tables within the currently selected database.
```sql
SHOW TABLES;
```

### C. Describe Table Structure
Shows column names, datatypes, null status, keys, and default values.
```sql
DESCRIBE table_name;
-- Or alternatively:
EXPLAIN table_name;
```

### D. Delete (Drop) a Table
Permanently deletes a table and all its rows.
```sql
DROP TABLE table_name;
```

### E. Alter a Table
The `ALTER TABLE` command is used to add, delete, or modify columns in an existing table.

#### 1. ADD Column
Adds a new column to an existing table.
```sql
ALTER TABLE table_name
ADD column_name datatype;
```

#### 2. DROP (Delete) Column
Removes an existing column from a table.
```sql
ALTER TABLE table_name
DROP COLUMN column_name;
```

#### 3. MODIFY Column
Changes the datatype or constraint of an existing column.
```sql
ALTER TABLE table_name
MODIFY COLUMN column_name new_datatype;
```

---

## 7. Data Manipulation: INSERT, UPDATE, and DELETE

Data Manipulation Language (DML) commands allow you to manage the actual records inside your tables.

### A. INSERT Command
Used to add new rows of data into a table.

#### Insert Values (Specifying Columns)
Best practice syntax specifying which columns receive which values.
```sql
INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);
```

#### Insert Values (All Columns)
Inserts values for every column in the exact order they are defined in the schema.
```sql
INSERT INTO table_name
VALUES (value1, value2, value3);
```

#### Insert Multiple Rows
Inserts several rows of data using a single query.
```sql
INSERT INTO table_name (column1, column2, column3)
VALUES 
    (valueA1, valueA2, valueA3),
    (valueB1, valueB2, valueB3),
    (valueC1, valueC2, valueC3);
```

---

### B. UPDATE Command
Used to modify existing records in a table. 

> [!WARNING]
> Always use a `WHERE` clause with the `UPDATE` command. If you omit `WHERE`, **all rows** in the table will be updated!

```sql
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;
```

**Example:**
```sql
UPDATE employees
SET salary = 50000
WHERE employee_id = 101;
```

---

### C. DELETE Command
Used to remove existing records from a table.

> [!WARNING]
> Always use a `WHERE` clause with the `DELETE` command. If you omit `WHERE`, **all rows** in the table will be deleted!

```sql
DELETE FROM table_name
WHERE condition;
```

**Example:**
```sql
DELETE FROM employees
WHERE employee_id = 101;
```

---

## 8. Table with Constraints Example

Here is an example of creating a table with various constraints applied to ensure data integrity:

```sql
CREATE TABLE employees (
    Id INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    Dob DATE,
    City VARCHAR(100),
    Joining_Date DATE,
    Is_active BOOLEAN
);
```

---

## 9. Querying Data: DQL SELECT Statements

Data Query Language (DQL) is used to fetch data from the database. The `SELECT` statement is the primary command used for this purpose.

### A. Basic Select
Retrieves all columns and all rows from a table.
```sql
SELECT * FROM employees;
```

### B. Specific Column
Retrieves only specified columns from a table to reduce overhead and focus on relevant data.
```sql
SELECT Id, Name, Salary FROM employees;
```

### C. WHERE Condition
Filters records based on a specific condition.
```sql
SELECT * FROM employees WHERE age > 25;
```

### D. AND Condition
Combines multiple conditions. A row is included in the result set if **all** conditions are true.
```sql
SELECT * FROM employees WHERE Gender = 'Male' AND Salary > 50000;
```

### E. OR Condition
Combines multiple conditions. A row is included if **at least one** condition is true.
```sql
SELECT * FROM employees WHERE city = 'Mumbai' OR city = 'Delhi';
```

### F. LIKE Condition
Performs pattern matching using wildcards (e.g., `%` matches zero or more characters).
```sql
SELECT * FROM employees WHERE Name LIKE 'A%';
```

### G. BETWEEN
Selects values within a given range (inclusive of start and end values).
```sql
SELECT * FROM employees WHERE salary BETWEEN 40000 AND 60000;
```

### H. ORDER BY
Sorts the result set in ascending (`ASC`) or descending (`DESC`) order.
```sql
SELECT * FROM employees ORDER BY salary ASC;
```

### I. LIMIT (Offset)
Restricts the number of returned rows. Optionally, `OFFSET` can be used to skip a specified number of rows before beginning to return the records.

**Get top 3 highest salaries:**
```sql
SELECT * FROM employees ORDER BY salary DESC LIMIT 3;
```

**Skip first 5 rows and show next 5 rows:**
```sql
SELECT * FROM employees LIMIT 5 OFFSET 5;
```

### J. DISTINCT
Removes duplicate rows from the query results, returning only unique values.
```sql
SELECT DISTINCT city FROM employees;
```

---

## 10. Transaction Control & Autocommit

A **Transaction** is a single logical unit of database work that consists of one or more SQL statements. Transactions are crucial for ensuring data integrity and follow the **ACID** properties:
* **Atomicity:** All operations inside the transaction must succeed, or none do (All-or-Nothing).
* **Consistency:** Keeps database state valid before and after the transaction.
* **Isolation:** Transactions run independently of each other without interference.
* **Durability:** Once committed, changes are permanently saved and survive system failures.

### A. Autocommit Behavior
In standard SQL environments (like MySQL), **Autocommit** is enabled by default. This means every individual SQL command (like `INSERT`, `UPDATE`, `DELETE`) is executed and immediately saved permanently to the database as a finished transaction.

To control transactions manually, we can disable autocommit:
```sql
-- Disable autocommit session-wide
SET autocommit = 0;

-- Or start an explicit transaction block (recommended)
START TRANSACTION;
```

When autocommit is disabled (or a transaction block is started), changes are temporary and only visible to the current session until they are committed.

### B. Commit & Rollback
* **`COMMIT`:** Saves all changes made during the current transaction permanently to the database.
* **`ROLLBACK`:** Reverts/undoes all changes made during the current transaction, returning the database to the state of the last committed transaction or a set `SAVEPOINT`.

```sql
START TRANSACTION;

UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;

-- If both updates succeed, save permanently:
COMMIT;

-- If something goes wrong, revert everything:
ROLLBACK;
```

---

## 11. SQL Functions: Single-Row & Aggregate

SQL provides various built-in functions to perform calculations and manipulate data. These are broadly divided into two types:

### A. Single-Row (Scalar) Functions
These functions operate on a single record/row at a time and return exactly one result value for every row processed.

* **String Functions:**
  * `UPPER(str)` / `LOWER(str)`: Converts casing.
  * `CONCAT(str1, str2, ...)`: Joins strings.
  * `SUBSTRING(str, pos, len)`: Extracts part of a string.
  * `LENGTH(str)`: Returns character count.
* **Numeric Functions:**
  * `ROUND(val, decimals)`: Rounds a number.
  * `ABS(val)`: Returns the absolute value.
* **Date Functions:**
  * `NOW()` / `CURDATE()`: Returns current timestamp/date.
  * `DATEDIFF(date1, date2)`: Returns difference in days.

**Example:**
```sql
SELECT Name, UPPER(Name), Salary, ROUND(Salary, 0) FROM employees;
```

### B. Aggregate Functions
These functions operate on multiple rows of a column combined and return a single summary value for the entire group.

* **`COUNT(column)`**: Returns the number of non-null values.
* **`SUM(column)`**: Returns the total sum of numeric values.
* **`AVG(column)`**: Returns the average of numeric values.
* **`MIN(column)`**: Returns the lowest value.
* **`MAX(column)`**: Returns the highest value.

**Example:**
```sql
SELECT 
    COUNT(*) AS total_employees, 
    SUM(Salary) AS total_payroll, 
    AVG(Salary) AS average_salary,
    MIN(Salary) AS lowest_salary, 
    MAX(Salary) AS highest_salary 
FROM employees;
```

---

## 12. Foreign Key Constraints & Referential Integrity

### 🔑 Primary Key vs. Foreign Key
* **Primary Key (PK):** A column (or combination of columns) that uniquely identifies a row in its own table. It cannot contain `NULL` values.
* **Foreign Key (FK):** A column in a table that references the Primary Key of another table (the parent table). It is used to establish relationships and maintain referential integrity.

---

### 🛡️ Default Foreign Key Behavior (FK Protection)
By default, databases enforce **Foreign Key Protection**. This means that if a row in the parent table is referenced by one or more rows in the child table:
* You **cannot delete** the parent row.
* You **cannot update** the parent row's primary key value.
* Attempting to do so will result in a referential integrity violation error, protecting your database from containing orphaned child records.

---

### 🔄 Referential Actions (On Delete & On Update)
We can customize the default behavior using referential actions defined on the Foreign Key constraint.

#### 1. ON DELETE CASCADE
If a row in the parent table is deleted, all matching rows in the child table will be **automatically deleted**.
```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);
```

#### 2. ON DELETE SET NULL
If a row in the parent table is deleted, the foreign key columns of the matching rows in the child table will be set to `NULL`.
* *Note: The child column must not be defined as `NOT NULL` for this to work.*
```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL
);
```

#### 3. ON DELETE NO ACTION / RESTRICT
The default behavior. Any delete or update operation on the parent table that would orphan child records is **rejected** and throws an error.
```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE NO ACTION
);
```

---

### 🛠️ Modifying Foreign Key Constraints
If you need to change a foreign key's behavior (e.g., from default `RESTRICT` to `ON DELETE CASCADE`), you must first drop the existing constraint and then add the new one.

#### Step 1: Drop the Existing Foreign Key
To drop a foreign key, you need to know its constraint name. You can find this name by running `SHOW CREATE TABLE child_table;`.
```sql
ALTER TABLE child_table 
DROP FOREIGN KEY fk_constraint_name;
```

#### Step 2: Add the New Foreign Key Constraint with Cascade
Add the constraint back with the desired cascading behavior:
```sql
ALTER TABLE child_table 
ADD CONSTRAINT fk_constraint_name 
FOREIGN KEY (child_column) 
REFERENCES parent_table(parent_column) 
ON DELETE CASCADE;
```
---

## 13. SQL Joins: INNER, LEFT, and RIGHT

**Joins** are used to combine rows from two or more tables based on a related column between them.

### 🤝 Types of Joins

#### 1. INNER JOIN
Returns records that have matching values in **both** tables.
```sql
SELECT columns
FROM table1
INNER JOIN table2 ON table1.common_column = table2.common_column;
```
#### 2. LEFT (OUTER) JOIN
Returns **all** records from the left table, and the matched records from the right table. If there is no match, the result is `NULL` from the right side.
```sql
SELECT columns
FROM table1
LEFT JOIN table2 ON table1.common_column = table2.common_column;
```

#### 3. RIGHT (OUTER) JOIN
Returns **all** records from the right table, and the matched records from the left table. If there is no match, the result is `NULL` from the left side.
```sql
SELECT columns
FROM table1
RIGHT JOIN table2 ON table1.common_column = table2.common_column;
```
---

### 🔍 Joins with WHERE Conditions
We can filter join results using the `WHERE` clause. This is also commonly used to find unmatched records (orphans).

#### A. Filter Matched Records (e.g., Salary > 50,000)
```sql
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary > 50000;
```

#### B. Find Unmatched Records on Left (e.g., Employees with no Department)
```sql
SELECT e.emp_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE e.dept_id IS NULL;
```

#### C. Find Unmatched Records on Right (e.g., Departments with no Employees)
```sql
SELECT d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;
```

---

## 14. Self Join

A **Self Join** is a regular join in which a table is joined with itself. This is useful for querying hierarchical data or comparing rows within the same table.

Since the same table is referenced twice, you **must** use table aliases to distinguish the left side of the table from the right side.

### 📝 Syntax
```sql
SELECT a.column_name, b.column_name...
FROM table_name a
JOIN table_name b ON a.common_column = b.common_column;
```

### 💡 Example (Employee-Manager Hierarchy)
Consider an `employees` table where each employee has a `manager_id` pointing to the `id` of another employee in the same table:

| id | name | manager_id |
|---|---|---|
| 1 | Alice | NULL |
| 2 | Bob | 1 |
| 3 | Charlie | 1 |
| 4 | David | 2 |

To find who manages whom:
```sql
SELECT 
    e.name AS Employee, 
    m.name AS Manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;
```

**Output:**
| Employee | Manager |
|---|---|
| Alice | NULL |
| Bob | Alice |
| Charlie | Alice |
| David | Bob |

---

## 15. Grouping Data: GROUP BY & HAVING

The `GROUP BY` statement groups rows that have the same values into summary rows. It is typically used with aggregate functions (`COUNT()`, `MAX()`, `MIN()`, `SUM()`, `AVG()`) to group the result-set by one or more columns.

### ⚠️ The HAVING Clause
The `HAVING` clause was added to SQL because the `WHERE` keyword cannot be used with aggregate functions (like `SUM`, `AVG`, `COUNT`, etc.). It is used to filter records **after** the grouping has taken place.

#### 🔍 Difference Between WHERE and HAVING

| Feature | `WHERE` | `HAVING` |
| :--- | :--- | :--- |
| **Applicability** | Filters individual rows **before** groups are formed. | Filters groups **after** `GROUP BY` is applied. |
| **Aggregate Functions** | **Cannot** be used with aggregate functions (e.g., `WHERE SUM(Salary) > 50000` is invalid). | **Can** be used with aggregate functions. |
| **Usage** | Can be used with `SELECT`, `UPDATE`, `DELETE`. | Can only be used with `SELECT` queries (typically with `GROUP BY`). |

### 📝 Syntax
```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE condition -- Filters rows
GROUP BY column_name -- Groups rows
HAVING aggregate_condition; -- Filters groups
```

### 💡 Examples

#### A. Group Employees by City and Count Them
```sql
SELECT City, COUNT(Id) AS total_employees
FROM employees
GROUP BY City;
```

#### B. Find Average Salary of Active Employees in Each City
```sql
SELECT City, AVG(Salary) AS average_salary
FROM employees
WHERE Is_active = true
GROUP BY City;
```

#### C. Find Cities with More Than 5 Employees (Using HAVING)
```sql
SELECT City, COUNT(Id) AS total_employees
FROM employees
GROUP BY City
HAVING COUNT(Id) > 5;
```

---

## 16. Set Operations: UNION & UNION ALL

The `UNION` and `UNION ALL` operators are used to combine the result-sets of two or more `SELECT` statements into a single result-set.

### 📋 Rules for Union Operations:
1. Each `SELECT` statement within the union must have the **same number of columns**.
2. The columns must also have **similar data types**.
3. The columns in each `SELECT` statement must be in the **same order**.

### 🔄 Difference Between UNION and UNION ALL
* **`UNION`**: Combines the results and **removes duplicate rows** (only returns distinct values).
* **`UNION ALL`**: Combines the results and **retains all rows**, including duplicates (faster than `UNION` because it doesn't perform duplicate checking).

### 📝 Syntax
```sql
-- Returns distinct values
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;

-- Returns all values (including duplicates)
SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2;
```

### 💡 Example
Suppose we have a `customers` table and a `suppliers` table, both containing `City` information:

```sql
-- Find all unique cities where customers and suppliers are located
SELECT City FROM customers
UNION
SELECT City FROM suppliers
ORDER BY City;

-- Find all cities (including duplicates if both a customer and supplier are in the same city)
SELECT City FROM customers
UNION ALL
SELECT City FROM suppliers
ORDER BY City;
```

---

## 17. SQL Views

A **View** is a virtual table in SQL that is based on the result-set of an SQL statement. It contains rows and columns just like a real table, but it does not store the data physically. Instead, it dynamically retrieves the data from the underlying tables (known as base tables) whenever it is queried.

### 🛡️ Advantages of Views
1. **Simplicity:** Simplifies complex queries. Instead of writing complex joins or subqueries repeatedly, you can create a view and query it like a simple table.
2. **Security:** Restricts data access. You can expose only specific columns or rows of a table to certain users while hiding sensitive data (e.g., hiding salary details or passwords).
3. **Consistency:** Provides a consistent structure. Even if the underlying table structure changes, the view can remain the same (by mapping columns accordingly), preventing external applications from breaking.
4. **Data Integrity:** You can create read-only views to prevent users from accidentally modifying database records.

---

### 📝 Syntax & Examples

#### A. Create a View
Creates a virtual table containing selected columns and rows.
```sql
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

**Example:**
```sql
-- Create a view showing only active employees with high salaries
CREATE VIEW active_high_earners AS
SELECT Id, Name, Salary, City
FROM employees
WHERE Is_active = true AND Salary > 60000;
```

#### B. Querying a View
Querying a view is identical to querying a normal table.
```sql
SELECT * FROM active_high_earners WHERE City = 'Mumbai';
```

#### C. Show All Views
To list all the views created in the current database:

* **In MySQL:**
  ```sql
  -- Lists all tables and views, indicating their types
  SHOW FULL TABLES WHERE Table_type = 'VIEW';
  ```
* **In PostgreSQL:**
  ```sql
  -- Lists all views in the current schema
  SELECT table_name FROM information_schema.views WHERE table_schema = 'public';
  ```
* **In SQL Server:**
  ```sql
  -- Lists all user-defined views
  SELECT name FROM sys.views;
  ```

#### D. Delete (Drop) a View
Removes the view from the database without affecting the underlying data in the base tables.
```sql
DROP VIEW view_name;
```

**Example:**
```sql
DROP VIEW active_high_earners;
```
```

