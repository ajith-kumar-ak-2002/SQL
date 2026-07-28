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

