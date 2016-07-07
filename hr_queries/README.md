# HR queries

This kata may be used to learn about the different type of cursors and to know *how to choose the right cursor* depending on your needs.

## Setup

This kata relies on data from the HR sample schema.

The setup details vary depending on your situation:

* HR schema is installed and you have access : great, setup is done!
* HR schema is not installed and you have access to the SYS password, read the standard setup section.
* HR schema is not installed and you have access to a user able to create another user : read the new user setup section.
* HR schema is not installed and you can't create another user : read the existing schema setup section.

### Standard setup

In this scenario the HR user will be dropped and recreated.

Connect to the database using sql*plus (user SYS or SYSTEM) and run script `setup/hr_main.sql`:

    @hr_main.sql hr_user_password default_tablespace temporary_tablespace sys_password tns_alias

To perform cleanup, run script `setup/hr_drop.sql` or simply drop user HR.

### Setup in an a new schema

In this scenario a new user will be created : it will be the owner of all RH objects.

Connect to the database using sql*plus (user able to create another user) and run script `setup/new_user_main.sql`.

    @hr_main.sql new_user_name new_user_password default_tablespace temporary_tablespace super_user_name super_user_password tns_alias

To perform cleanup, run script `setup/no_user_drop.sql` or simply drop the new user.

### Setup in an existing schema

In this scenario an existing user will will be the owner of all RH objects.

Connect to the database using sql*plus (existing user) and run script `setup/no_user_main.sql`.

To perform cleanup, run script `setup/no_user_drop.sql`.


## Walkthrough

The kata will require to write several functions, the preliminary step is to declare a package that will regroup them all. Then follow the below steps in the order.

### Step 1

Write a function that returns the first and last name of an employee given his id. If the id matches more than one name or if it doesn't match any the function should raise an error.

### Step 2

Write a function

*Use case* : itérer sur le résultat d'un query, comme ici par exemple pour afficher une liste "courte" sur la console

**implicit cursor**
**for ... in**

### Step 3

1 - Write a function that returns a result set composed of the following columns of the EMPLOYEES table :
FIRST_NAME, LAST_NAME, EMPLOYEE_ID

The query should return all rows for the employees of the "IT" departement.

2 - Write a procedure using the above function and displaying the result set.

### Step 4

Write a function that returns a result set composed of the following columns of the EMPLOYEES table :
FIRST_NAME, LAST_NAME, SALARY

The contents of the result set depends on the value of an argument `salary_rank`:

* If the value is "ALL" then the query should return all rows for the "Sales Representative" employees.
* If the value is "AVG_ABOVE" then the query should return all rows for the "Sales Representative" employees earning more than the average salary of the "Sales" department.

*Use case* : retourner un result set généré à partir d'un query choisi parmi plusieurs selon un paramètre d'entrée.
Dans ce premier cas les deux queries ont la même structure et sont donc candidats à être strong typed.

**explicit cursor**
**static REF cursor**
**strong typed**

select
       emp.*
  from
       hr.employees   emp JOIN
       hr.jobs        j   ON (emp.job_id = j.job_id) JOIN
       hr.departments dep ON (emp.department_id = dep.department_id)
 where
       j.job_title = 'Sales Representative'
   and emp.salary > (
                     select
                            avg(emp.salary) as avg_sales_dep_salary
                       from
                            hr.employees   emp JOIN
                            hr.departments dep ON (emp.department_id = dep.department_id)
                      where
                            dep.department_name = 'Sales'
                    )
;

### Step 5

Extending the function created in previous step, a new value "AVG_BELOW" may be assigned to the argument `salary_rank`. In this case the function should return a result set composed of the following columns of the EMPLOYEES table :   
FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY

In this case the query should return all rows for the "Sales Representative" employees earning less than the average salary of the "Sales" department.

*Use case* : idem cas précédent mais les différents result set ont des structures différentes

**explicit cursor**
**static REF cursor**
**weak typed**

### Step 6

1. retourner un result set dont le query n'est pas connu au moment du compile time
cas typique : différentes clauses where
**explicit cursor**
**dynamic REF cursor**