# HR queries

## Walkthrough

The kata will require to write several functions, the preliminary step is to declare a package that will regroup them all. Then follow the below steps in the order.

### Step 1

Write a function that returns the first and last name of an employee given his id. If the id matches more than one name or if it doesn't match any the function should raise an error.

*Use case* : retourner une et une seule ligne depuis un query.

*Purpose of this step*

**implicit cursor**
**select ... into**

Cursor is implicit because it does not require to be opened explicitly (nor fetched and closed explicitly).
Code is concise and naturally handles the requirement : the query should return one and only one row.


### Step 2

It is not the fact that it is declared or not that makes it explicit : an implicit cursor may be declared using the "for ... in" syntax.
