# Training results

Given the table TRAINING_RESULTS :

```
SQL> desc TRAINING_RESULTS
 Name                       Null?    Type
 -------------------------- -------- -------------
 TRAINING_NAME              NOT NULL VARCHAR2(20)
 TRAINING_STEP              NOT NULL NUMBER(38)
 COMPLETION_DATE                     DATE
 ```

 Knowing that a training is completed when all steps have a date,
 which trainings are 100% completed?

### Samples

```
 TRAINING_NAME        TRAINING_  COMPLETION_DATE
 -------------------- ---------- ------------------
 J2EE                          1 03-FEB-05
 J2EE                          2 03-FEB-05
 J2EE                          3 03-FEB-05
 J2EE                          4 03-FEB-05
 J2EE                          5 03-FEB-05
 SmallTalk                     1 14-OCT-12
 SmallTalk                     2 11-SEP-12
 SmallTalk                     3 01-NOV-12
 C                             1 31-AUG-88
 C                             2
 C                             3 03-SEP-88
 Groovy                        1 25-APR-15
 Groovy                        2 08-JUL-15
 Groovy                        3 22-AUG-15
 Groovy                        4
 ```

In this case the expected results should be a result set with the column TRAINING_NAME (  "J2EE", "SmallTalk") :
```
 TRAINING_NAME
 ------------------
 J2EE
 SmallTalk
 ```


### Setup

First create the necessary schema tables using the file training_results_setup.sql

```
SQL>@training_results_setup.sql
```
