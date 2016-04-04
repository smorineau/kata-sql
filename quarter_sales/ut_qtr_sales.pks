CREATE OR REPLACE PACKAGE ut_qtr_sales
IS

   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;

   PROCEDURE ut_load_year_sales;

END ut_qtr_sales;
/

show err