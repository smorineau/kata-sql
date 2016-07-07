# HR queries

## Walkthrough

The kata will require to write several functions, the preliminary step is to declare a package that will regroup them all. Then follow the below steps in the order.

### Step 1

Write a function that returns the first and last name of an employee given his id. If the id matches more than one name or if it doesn't match any the function should raise an error.

*Use case* : return one and only one row.

*Purpose of this step*

**implicit cursor**
**select ... into**

Cursor is implicit because it does not require to be opened explicitly (nor fetched and closed explicitly).
Code is concise and naturally handles the requirement : the query should return one and only one row.

*Example details*

Use ID 1 for no_data_found, ID 105 for too_many_rows.

function get_employee_name is an example with a "select ... into" construct.
function get_employee_name_explicit is an example with an explicit cursor : fetch is done twice and code is longer.

### Step 2

Write a procedure that displays the following columns of the EMPLOYEES table :
FIRST_NAME, LAST_NAME, HIRE_DATE, SALARY

The procedure should display all rows for the employees of the "Shipping" departement (columns may be comma-separated).

*Use case* : iterate on a result set, comme ici par exemple pour afficher une liste "courte" sur la console. If it can't be done in plain SQL, then use an implicit cursor loop.

*Purpose of this step*

**implicit cursor**
**for ... in**

No need to open, fetch and close the cursor.
No need to test for the loop exit condition ("EXIT WHEN cursor%NOTFOUND").
No need to declare the assignment variable : it is implicitly declared and correctly typed to hold the cursor's result set structure.

Optionally the cursor may be declared.

*Example details*

No test required in this step.
procedure display_shipping_employees : inline cursor
procedure display_shipping_employees2 : declared cursor

### Step 3

1 - Write a function that returns a result set composed of the following columns of the EMPLOYEES table :
FIRST_NAME, LAST_NAME, EMPLOYEE_ID

The query should return all rows for the employees of the "IT" departement.

2 - Write a procedure using the above function and displaying the result set.

*Use case* : pass a result set to a client

*Purpose of this step*

**explicit cursor**
**static REF cursor**

It is up to the client to perform the FETCH and CLOSE for the cursor.

Introduce/review the Cursor attributes:
*cursor*%FOUND          Returns TRUE if a record was fetched successfully
*cursor*%NOTFOUND       Returns TRUE if a record was not fetched successfully
*cursor*%ROWCOUNT       Returns the number of rows fetched from the specified cursor at that point in time
*cursor*%ISOPEN         Returns TRUE if the specified cursor is opened

*Example details*

function get_it_employees implements an example.
procedure display_it_employees is a pl/sql client of get_it_employees function.

