CREATE OR REPLACE PACKAGE ut_trainings
IS

   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;

   PROCEDURE ut_get_completed_trainings;

END ut_trainings;
/

show err