# SQL

Welcome to my SQL playground!

## Table of Contents

- [SQL](#sql)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Data Types](#data-types)
  - [Operators](#operators)
  - [Functions](#functions)
  - [Queries](#queries)
  - [Joins](#joins)
  - [Subqueries](#subqueries)
  - [Views](#views)


---

## Introduction

SQL (Structured Query Language) is a domain-specific language used in programming and designed for managing data held in a relational database management system (RDBMS), or for stream processing in a relational data stream management system (RDSMS). It is particularly useful in handling structured data, i.e. data incorporating relations among entities and variables.

SQL offers two main advantages over older read–write APIs such as ISAM or VSAM. Firstly, it introduced the concept of accessing many records with one single command. Secondly, it eliminates the need to specify how to reach a record, e.g. with or without an index.

SQL was one of the first commercial languages to utilize Edgar F. Codd's relational model. The model was described in his influential 1970 paper, "A Relational Model of Data for Large Shared Data Banks".

Despite not strictly adhering to the relational model as described by Codd, it became the most widely used database language.

---

## Data Types

SQL data types can be broadly divided into following categories:

- Numeric data types
- Date and Time data types
- Character string data types
- Unicode character string data types
- Binary data types
- Miscellaneous data types
- Collection data types
- JSON data types
- Spatial data types
- XML data types
- User-defined data types
- Row data types
- Reference data types
- Domain data types
- Array data types

---

## Operators

SQL operators are used to perform operations on values and variables. They can be classified into following categories:

- Arithmetic operators
- Comparison operators
- Logical operators
- Bitwise operators
- Assignment operators
- Special operators
- NULL-related operators
- Regular expression operators
- JSON operators
- XML operators
- Array operators
- Range operators
- Type cast operators

---

## Functions

SQL functions are divided into two categories:

- Aggregate functions
- Scalar functions

---

## Queries

SQL queries are used to retrieve data from a database. The standard SQL commands to interact with relational databases are:

- SELECT - extracts data from a database
- UPDATE - updates data in a database
- DELETE - deletes data from a database
- INSERT INTO - inserts new data into a database
- CREATE DATABASE - creates a new database
- ALTER DATABASE - modifies a database
- CREATE TABLE - creates a new table
- ALTER TABLE - modifies a table
- DROP TABLE - deletes a table
- CREATE INDEX - creates an index (search key)
- DROP INDEX - deletes an index
- TRUNCATE TABLE - deletes all records in a table, including all spaces allocated for the records are removed
- COMMENT - add comments to the data dictionary
- EXPLAIN PLAN - explains access path to data
- SELECT INTO - copies data into a new table
- CREATE VIEW - creates a view based on a query
- DROP VIEW - deletes a view
- GRANT - gives user's access privileges to database
- REVOKE - withdraws user's access privileges to database
- COMMIT - saves work done
- ROLLBACK - restores database to original since the last COMMIT command
- SAVEPOINT - identifies a point in a transaction to which you can later roll back
- SET TRANSACTION - places a name on a transaction
- MERGE - UPSERT operation (insert or update)
- CALL - calls a PL/SQL or Java subprogram
- EXPLAIN PLAN - explains access path to data
- LOCK TABLE - controls concurrency

---

## Joins

SQL joins are used to combine rows from two or more tables based on a related column between them. The most common types of joins are:

- INNER JOIN (or sometimes called simple join)
- LEFT JOIN (or LEFT OUTER JOIN)
- RIGHT JOIN (or RIGHT OUTER JOIN)
- FULL JOIN (or FULL OUTER JOIN)

---

## Subqueries

A subquery is a query within another query. The outer query is called as main query and inner query is called as subquery. The subquery must be enclosed with parenthesis and generally executes first, and its output is used to complete the query condition for the main query.

---

## Views

A view is a virtual table based on the result-set of an SQL statement. A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database. You can add SQL functions, WHERE, and JOIN statements to a view and present the data as if the data were coming from one single table.

```sql
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

```sql
SELECT * FROM view_name;
```

```sql
DROP VIEW view_name;
```

```sql
CREATE OR REPLACE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

```sql
ALTER VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

---
