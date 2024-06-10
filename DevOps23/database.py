import sqlite3

usernames = []

DATABASE = "devops23.db"
conn = sqlite3.connect(DATABASE)
cursor = conn.cursor()


def initiate_db():
    """Creates the database and the users table"""
    with conn:
        cursor.execute(
            """CREATE TABLE IF NOT EXISTS users (name text, username text, clean_name text, total_contributions integer, active boolean)"""
        )
        conn.commit()


def create_user_table():
    """Creates a table for each clean_name in the users table"""
    with conn:
        cursor.execute("""SELECT clean_name FROM users""")
        names = cursor.fetchall()
        for name in names:
            cursor.execute(
                """CREATE TABLE IF NOT EXISTS """
                + name[0]
                + """ (date text, contributions integer)"""
            )
            conn.commit()


def update_activity(name, is_active):
    """Updates the active column in the users table"""
    with conn:
        cursor.execute(
            """UPDATE users SET active = ? WHERE clean_name = ?""", (is_active, name)
        )
        conn.commit()


def update_username():
    """Updates the username in the users table"""
    with conn:
        cursor.execute("""SELECT username FROM users""")
        usernames_in_db = cursor.fetchall()
        for user in usernames:
            for name, username in user.items():
                if (username,) not in usernames_in_db:
                    print(f"New username for {name}: {username}")
                    cursor.execute(
                        """UPDATE users SET username = ? WHERE name = ?""",
                        (username, name),
                    )
                    conn.commit()


def insert_contributions(name, date, contributions):
    """Inserts the date and contributions into the specified user table"""
    with conn:
        cursor.execute(
            """INSERT INTO """ + name + """ VALUES (?, ?)""", (date, contributions)
        )
        conn.commit()


def update_user_table(name, total_contributions):
    """Updates the total_contributions number
    and the active column in the users table"""
    with conn:
        cursor.execute(
            """SELECT total_contributions FROM users WHERE clean_name = ?""", (name,)
        )
        old_total_contributions = cursor.fetchone()
        if total_contributions == old_total_contributions[0]:
            update_activity(name, False)
        else:
            update_activity(name, True)
        cursor.execute(
            """UPDATE users SET total_contributions = ? WHERE clean_name = ?""",
            (total_contributions, name),
        )
        conn.commit()


def modify_total_contributions(name, total_contributions):
    """Modifies the total_contributions column in the users table"""
    with conn:
        cursor.execute(
            """UPDATE users SET total_contributions = ? WHERE clean_name = ?""",
            (total_contributions, name),
        )
        conn.commit()


def build_database():
    """Inserts all the users into the database"""
    initiate_db()
    create_user_table()
    for user in usernames:
        for name, username in user.items():
            clean = name.replace(" ", "_").lower()
            total_contributions = 0
            with conn:
                cursor.execute(
                    """INSERT INTO users VALUES (?, ?, ?, ?, ?)""",
                    (name, username, clean, total_contributions, False),
                )
                conn.commit()

    with conn:
        cursor.execute("""SELECT clean_name FROM users""")
        names = cursor.fetchall()
        for name in names:
            cursor.execute(
                """CREATE TABLE IF NOT EXISTS """
                + name[0]
                + """ (date text, contributions integer)"""
            )
            conn.commit()


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


def delete_user():
    """Deletes the user from the database if the username is not in the usernames list"""
    usernames_list = []
    for user in usernames:
        for name, username in user.items():
            usernames_list.append(username)

    with conn:
        cursor.execute("""SELECT username FROM users""")
        usernames_in_db = [item[0] for item in cursor.fetchall()]

        for username in usernames_in_db:
            if username not in usernames_list:
                print(username)
                cursor.execute(
                    """SELECT clean_name FROM users WHERE username = ?""",
                    (username,),
                )
                clean_name = cursor.fetchone()[0]
                cursor.execute("""DROP TABLE IF EXISTS """ + clean_name)
                cursor.execute("""DELETE FROM users WHERE username = ?""", (username,))


def alphabetical_order():
    """Get the users alphabetically"""
    with conn:
        cursor.execute(
            """SELECT name, username, clean_name, total_contributions, active FROM users
            ORDER BY name ASC"""
        )
        users = cursor.fetchall()
    return users


def contributions_order():
    """Sort the users by total_contributions"""
    with conn:
        cursor.execute(
            """SELECT name, username, clean_name, total_contributions, active FROM users
            ORDER BY total_contributions DESC"""
        )
        users = cursor.fetchall()
    return users


def get_users():
    """Get the users from the database"""
    with conn:
        cursor.execute("""SELECT name, username, clean_name FROM users""")
        users = cursor.fetchall()
    return users


def delete_rows(number_of_times):
    """Delete the last row in every user table in the database a given number of times"""
    with conn:
        cursor.execute("""SELECT clean_name FROM users""")
        names = cursor.fetchall()
        for name in names:
            for _ in range(number_of_times):
                cursor.execute(
                    """DELETE FROM """
                    + name[0]
                    + """ WHERE ROWID IN (SELECT MAX(ROWID) FROM """
                    + name[0]
                    + """)"""
                )
                conn.commit()


def check_activity():
    """Check the correctitude of the database"""
    with conn:
        cursor.execute("""SELECT clean_name FROM users""")
        names = cursor.fetchall()
        for name in names:
            cursor.execute(
                """SELECT contributions FROM ? ORDER BY ROWID DESC LIMIT 2""",
                (name[0],),
            )
            contributions = cursor.fetchall()
            if contributions[0][0] == contributions[1][0]:
                update_activity(name[0], False)
            else:
                update_activity(name[0], True)


def delete_table(table_name):
    """Deletes a table from the database"""
    with conn:
        cursor.execute("""DROP TABLE IF EXISTS """ + table_name)
        conn.commit()


def main():
    """Main function"""
    # build_database()
    # add_new_user()
    # update_username()
    # delete_user()
    # delete_rows(1)
    # check_activity()
    # delete_table("users")


if __name__ == "__main__":
    main()
