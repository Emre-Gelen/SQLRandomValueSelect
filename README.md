A query that allows you select a random value from tables by column name.

# How it works

- First query, get all tables that includes column named {columnName} which you enter as parameter.
- After that, query creates queries for each table.
- Then runs created queries and insert result to declared table.
- Finally, select a random value from declared table.

