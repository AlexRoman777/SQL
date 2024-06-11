# SQL

Welcome to my SQL playground!

## Projects

- [Landlord](Landlord/README.md)
- [Library](Library/README.md)
- [DevOps23](DevOps23/README.md)

## Table of Contents

- [SQL](#sql)
  - [Projects](#projects)
  - [Table of Contents](#table-of-contents)
  - [SQL Introduction](#sql-introduction)
  - [Data Types](#data-types)
  - [Operators](#operators)
  - [Queries](#queries)
  - [Joins](#joins)
  - [Subqueries](#subqueries)
  - [Views](#views)
  - [Normalization](#normalization)

---

## SQL Introduction

SQL (Structured Query Language) is a standardized programming language that's used to manage relational databases and perform various operations on the data in them. Initially created in the 1970s, SQL is regularly used by database administrators, as well as by developers writing data integration scripts and data analysts looking to set up and run analytical queries.

The uses of SQL include modifying database table and index structures; adding, updating and deleting rows of data; and retrieving subsets of information from within a database for transaction processing and analytics applications. Queries and other SQL operations take the form of commands written as statements -- commonly used SQL statements include SELECT, ADD, INSERT, UPDATE, DELETE, TRUNCATE, DROP and ALTER.

SQL became the de facto standard programming language for relational databases after they emerged in the late 1970s and early 1980s. Also known as SQL databases, relational systems comprise a set of tables containing data in rows and columns. Each column in a table corresponds to a category of data -- for example, customer name or address -- while each row contains a data value for the intersecting column.

[TOC](#table-of-contents)

---

## Data Types

SQL data types are used to specify the type of data that can be stored in a database table. Understanding the data types is crucial while designing your database. Here are some of the most commonly used data types:

- Numeric data types: Used to store numeric values. Examples include `INT`, `FLOAT`, `DECIMAL`, etc.

- Date and Time data types: Used to store date and time values. Examples include `DATE`, `TIME`, `DATETIME`, etc.

- Character string data types: Used to store character (string) values. Examples include `CHAR`, `VARCHAR`, `TEXT`, etc.

- Binary data types: Used to store binary data such as files, images, etc. Examples include `BINARY`, `VARBINARY`, `BLOB`, etc.

```sql
-- Example of creating a table with different data types
CREATE TABLE Employees (
    ID INT,
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    BirthDate DATE,
    Photo BLOB
);
```

[TOC](#table-of-contents)

---

## Operators

SQL operators are used to perform operations on data within your SQL statements. They can be classified into the following categories:

- Arithmetic operators: Used to perform mathematical operations. Examples include `+`, `-`, `*`, `/`, `%`, etc.

- Comparison operators: Used to compare one expression with another. Examples include `=`, `<>` (or `!=`), `>`, `<`, `>=`, `<=`, etc.

- Logical operators: Used to combine the result of two component conditions to produce a single result. Examples include `AND`, `OR`, `NOT`, etc.

```sql
-- Example of using operators
SELECT FirstName, Salary
FROM Employees
WHERE Salary > 50000 AND Salary < 100000;
```

[TOC](#table-of-contents)

---

## Queries

SQL queries are used to interact with the data in a database. Here are some of the most commonly used SQL commands:

- `SELECT`: Extracts data from a database.
- `UPDATE`: Updates data in a database.
- `DELETE`: Deletes data from a database.
- `INSERT INTO`: Inserts new data into a database.
- `CREATE DATABASE`: Creates a new database.
- `CREATE TABLE`: Creates a new table.
- `ALTER TABLE`: Modifies a table.
- `DROP TABLE`: Deletes a table.
- `CREATE INDEX`: Creates an index (search key).
- `DROP INDEX`: Deletes an index.
- `TRUNCATE TABLE`: Deletes all records in a table, including all spaces allocated for the records are removed.
- `GRANT`: Gives user's access privileges to database.
- `REVOKE`: Withdraws user's access privileges to database.
- `COMMIT`: Saves work done.
- `ROLLBACK`: Restores database to original since the last COMMIT command.

```sql
-- Create a new database
CREATE DATABASE testDB;

-- Use the new database
USE testDB;

-- Create a new table
CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    Name VARCHAR(20),
    Age INT,
    Salary DECIMAL(10, 2)
);

-- Insert new data into the table
INSERT INTO Employees (ID, Name, Age, Salary)
VALUES (1, 'John Doe', 30, 50000.00),
       (2, 'Jane Doe', 25, 60000.00),
       (3, 'Alice', 24, 70000.00),
       (4, 'Bob', 28, 80000.00);

-- Select data from the table
SELECT * FROM Employees;

-- Update data in the table
UPDATE Employees
SET Salary = Salary * 1.1
WHERE Age < 30;

-- Save changes
COMMIT;
```

[TOC](#table-of-contents)

---

## Joins

SQL joins are used to combine rows from two or more tables, based on a related column between them. It allows you to create a relationship between objects and structures within your database. Here are the most common types of joins:

- `INNER JOIN`: The INNER JOIN keyword selects records that have matching values in both tables.
- `LEFT (OUTER) JOIN`: The LEFT JOIN keyword returns all records from the left table (table1), and the matched records from the right table (table2). The result is NULL on the right side, if there is no match.
- `RIGHT (OUTER) JOIN`: The RIGHT JOIN keyword returns all records from the right table (table2), and the matched records from the left table (table1). The result is NULL on the left side, when there is no match.
- `FULL (OUTER) JOIN`: The FULL OUTER JOIN keyword returns all records when there is a match in either left (table1) or right (table2) table records.

```sql
-- Example of an INNER JOIN
SELECT Orders.OrderID, Customers.CustomerName
FROM Orders
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;
```

[TOC](#table-of-contents)

---

## Subqueries

A subquery, or nested query, is a query that is embedded within another SQL query. A subquery is used to return data that will be used in the main query as a condition to further restrict the data to be retrieved. Subqueries can be used with the SELECT, INSERT, UPDATE, and DELETE statements along with the operators like =, <, >, >=, <=, IN, BETWEEN, etc.

There are two types of subqueries:

- Single-row subquery, where the subquery returns only one row.
- Multiple-row subquery, where the subquery returns multiple rows,.

And two forms of subqueries:

- Correlated: In a SQL database query, a correlated subquery (also known as a synchronized subquery) uses values from the outer query. Because the correlated subquery depends on the outer query, the correlated subquery must be run once for every row in the outer query.
- Non-Correlated: A non-correlated subquery can be run independently of the outer query. It does not rely on the outer query for its values.

```sql
-- Example of a subquery
SELECT EmployeeID, FirstName, LastName, DepartmentID
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees)
ORDER BY EmployeeID;
```

[TOC](#table-of-contents)

---

## Views

A view is a virtual table based on the result-set of an SQL statement. A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database. You can add SQL functions, WHERE, and JOIN statements to a view and present the data as if the data were coming from one single table.

Views can be used for the following purposes:

- To focus, simplify, and customize the perception each user has of the database.
- As a security mechanism by allowing users to access data through the view, without granting the users permissions to directly access the underlying base tables.
- To provide a backward compatible interface to emulate a table whose schema has changed.

Here are the types of views in SQL:

- Simple View: It is based on one base table.
- Complex View: It is based on more than one base table.
- Inline View: It is a subquery with an alias (or correlation name) used in the FROM clause of another query.
- Materialized View: It is a physical copy, snapshot or a picture of the base table.

```sql
-- Creating a simple view
CREATE VIEW View_Employees AS
SELECT name, age
FROM Employees
WHERE age > 30;
```

[TOC](#table-of-contents)

---

## Normalization

Normalization is a systematic approach of decomposing tables to eliminate data redundancy and undesirable characteristics like Insertion, Update, and Deletion Anomalies. It is a multi-step process that puts data into tabular form by removing duplicated data from the relation tables.

Normalization is used for mainly two purposes:

- Eliminating redundant (useless) data.
- Ensuring data dependencies make sense i.e data is logically stored.

The database normalization process is divided into the following steps:

- First Normal Form (1NF): Each table cell should contain a single value and each record needs to be unique.
- Second Normal Form (2NF): It is in the 1NF and all non-key attributes are fully functional dependent on the primary key.
- Third Normal Form (3NF): It is in the 2NF and no non-key attribute is dependent on any other non-key attribute.
- Boyce-Codd Normal Form (BCNF): For any dependency A → B, A should be a super key.
- Fourth Normal Form (4NF): No multi-valued dependencies are allowed.

```sql
-- Example of normalization
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    City VARCHAR(50),
    Country VARCHAR(50),
    Phone VARCHAR(15)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
```

[TOC](#table-of-contents)

---
