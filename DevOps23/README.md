# DevOps23

<p align="center">
  <img src="demo.png" alt="DevOps23" width=80%/>
</p>

---

Where students learn that the secret ingredient to successful coding is 90% coffee, 10% luck, and 110% pretending to know what you're doing!


## Python + Sqlite3

A simple example of how to use the sqlite3 library in Python to create a new database, create a new table, insert data into the table, select data from the table, update data in the table, and save changes.

```python
# Import the sqlite3 library
import sqlite3

# Connect to the database
conn = sqlite3.connect('testDB.db')

# Create a cursor object
cursor = conn.cursor()

# Use the new database
cursor.execute('USE testDB')

# Create a new table
cursor.execute('CREATE TABLE Employees (ID INT PRIMARY KEY, Name VARCHAR(20), Age INT, Salary DECIMAL(10, 2))')

# Insert new data into the table
cursor.execute('INSERT INTO Employees (ID, Name, Age, Salary) VALUES (1, "John Doe", 30, 50000.00)')

# Select data from the table
cursor.execute('SELECT * FROM Employees')

# Update data in the table
cursor.execute('UPDATE Employees SET Salary = Salary * 1.1 WHERE Age < 30')

# Save changes
conn.commit()
```


## database.py

A few examples of functions I use to interact with the SQLite3 database for [DevOps23](https://devops23.se).

```python
def add_new_user():
    """Compare the usernames in the database with the usernames in the usernames list and add only the new ones"""
    with conn:
        cursor.execute("""SELECT username FROM users""")
        usernames_in_db = cursor.fetchall()
        for user in usernames:
            for name, username in user.items():
                if (username,) not in usernames_in_db:
                    clean = name.replace(" ", "_").lower()
                    total_contributions = 0
                    cursor.execute(
                        """INSERT INTO users VALUES (?, ?, ?, ?, ?)""",
                        (name, username, clean, total_contributions, False),
                    )
                    conn.commit()
                    cursor.execute(
                        """CREATE TABLE IF NOT EXISTS """
                        + clean
                        + """ (date text, contributions integer)"""
                    )
                    conn.commit()
```

---

Back to [Main README](../README.md)
