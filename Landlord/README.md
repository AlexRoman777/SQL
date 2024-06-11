# Landlord SQL

Create a database for a landlord in a city who wants to keep track of apartments rented to people

---

## Tables

---

### Apartments

- An apartment has a number of rooms and an area in square meters.
- An apartment is located on a floor and has a sequence number within that floor (floor + number is unique for each address).
- An apartment has a street address. There may be one or more apartments at the same address.

---

### Adresses

- A street address belongs to a house. A house can have one or more addresses (different gates).
- A house is located in a block, and has a sequence number within the block where it is located.
- A block may have one or more houses.
- A block has a property designation composed of the name of the municipality, the name of the area, the block number and the unit number (e.g. "Stockholm Norrmalm 5:3").

---

### Tenants

- A person has a personal identity number, first and last name, telephone number and e-mail address.
- The phone number and email address do not have to be unique.
- A person can only rent one apartment at a time.
- An apartment can be rented to several people who share the contract.

---

### Leases

- A lease is valid from a starting date and has an annual rent in SEK.
- If the rent changes, a new contract is created with a new start date, and the old contract is given an end date which is the day before the start date of the new contract.

---

## Tasks

---

### Task 1

Draw ER diagrams. Identify entities and relationships, and cardinalities. Preferably use "crow's foot notation". Briefly describe how you have interpreted the requirements, and justify the main design choices you have made.
Present with diagrams and short explanatory texts.

---

### Task 2

Create tables, using the ER diagram as a basis. Link related tables with primary and foreign keys. Add the rules for valid values, unique indices, etc. that you consider most important, and briefly justify why. Describe using SQL commands to create tables etc, in text form, with short explanatory texts.

---

### Task 3

Add sample data, either by inserting one record at a time or by importing from text files,
with a minimum of two blocks, each with at least two houses, with in turn at least two apartments per house, all rented to different people. Report with SQL commands to add data.

---

### Task 4

Make the following selection from the database.

#### Subtask 4.1

List active tenants in alphabetical order, with details of the addresses and other characteristics of the apartments they rent.

---

#### Subtask 4.2

List block names alphabetically, with data per block on number of houses, number of apartments, and total square meters.

---

#### Subtask 4.3

List data on number of blocks, number of houses, number of apartments, and total number of square metres, grouped by tract name (part of the property designation).

---

#### Subtask 4.4

List what the rents will be next calendar month for all unexpired leases.

Report with SQL commands for selection, with short explanatory texts if necessary.
For a grade of G, tasks 1-3 and 4.1-4.2 must be performed in a broadly acceptable manner.

---

Back to [Main README](../README.md)
