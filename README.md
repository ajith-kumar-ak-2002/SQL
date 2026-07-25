# 📊 SQL Learning Journey & Reference Guide

Welcome to my **SQL (Structured Query Language)** repository! This space serves as a comprehensive log and reference guide for everything I have learned during my SQL course. 

Inside, you will find detailed explanations, command syntaxes, and conceptual write-ups of core database principles.

---

## 🔍 Table of Contents
1. [What is a Database?](#1-what-is-a-database)
2. [Types of SQL Commands](#2-types-of-sql-commands)
3. [SQL Datatypes](#3-sql-datatypes)
4. [SQL Constraints](#4-sql-constraints)
5. [Database Administration Commands](#5-database-administration-commands)
6. [Table Administration Commands](#6-table-administration-commands)
7. [Data Manipulation: Insertions](#7-data-manipulation-insertions)

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

## 4. SQL Constraints
Constraints are rules applied to columns to limit the type of data that can go into a table. This ensures the accuracy and reliability of the data (data integrity).

* **`NOT NULL`**: Ensures that a column cannot have a `NULL` value.
* **`UNIQUE`**: Ensures that all values in a column are distinct.
* **`PRIMARY KEY`**: A combination of `NOT NULL` and `UNIQUE`. Uniquely identifies each row in a table.
* **`FOREIGN KEY`**: Prevents actions that would destroy links between tables. Links a column to a primary key in another table.
* **`CHECK`**: Ensures that the values in a column satisfy a specific condition.
* **`DEFAULT`**: Sets a default value for a column if no value is specified.

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
