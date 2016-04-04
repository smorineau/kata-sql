CREATE OR REPLACE PACKAGE ut_fizzbuzz
IS
   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;
   
   PROCEDURE ut_fizzbuzzme;
   PROCEDURE ut_direct_display;
END ut_fizzbuzz;
/