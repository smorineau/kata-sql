# Quarter Sales

Move the data from the QUARTER_SALES table to the 3 YEAR_SALES tables following these rules :

Year sales are less or equal than 500 : YEAR_SALES_LOW  
Year sales are comprised between 501 and 1000 : YEAR_SALES_MEDIUM  
Year sales are more than 1000 : YEAR_SALES_HIGH

### Setup

First create the necessary schema tables using the file  qtr_sales_setup.sql

```
SQL>@qtr_sales_setup.sql
```
