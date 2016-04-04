# Budget vs Actual

Given the below model :


![](Budget-Actual-Model.png?raw=true)



## Step 1

Write a function that compares budgeted amount vs actual amount by category.

*Sample for category 5100:*
```
  CATEGORY BUDGETED_COST ACTUAL_COST
---------- ------------- -----------
    5100	     265	 164
```

*Sample for category 5300:*
```
  CATEGORY BUDGETED_COST ACTUAL_COST
---------- ------------- -----------
    5300	     130	   0
```

## Step 2

Write a function that lists all categories having no remaining  budget.

*Expected output:*
```
  CATEGORY
----------
    5200
    5400
```

## Step 3

Update the Step 2 function so that it displays the balance of each out of budget category - sorted by balance.

*Expected output:*
```
  CATEGORY    BALANCE
---------- ----------
    5400	  -68
    5200	    0
```

Also expose the opposite function : the list of categories and their balance for categories having remaining budget.

*Expected output:*
```
  CATEGORY    BALANCE
---------- ----------
    5100	  101
    5300	  130
```


### Setup

First create the necessary schema tables using the file budget_vs_actual_setup.sql

```
SQL>@budget_vs_actual_setup.sql
```
