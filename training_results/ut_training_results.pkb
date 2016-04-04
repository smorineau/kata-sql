CREATE OR REPLACE PACKAGE BODY ut_trainings
IS

   PROCEDURE ut_setup
   IS
   BEGIN
        null;
   END;

   PROCEDURE ut_teardown
   IS
   BEGIN
        null;
   END;

   PROCEDURE ut_get_completed_trainings
   IS 
      proc_params   utplsql_util.utplsql_params;
   BEGIN
      -- Register the parameters
      -- IMPORTANT: The position starts with 0 for functions. For procedures it starts with 1
      utplsql_util.reg_out_param (0, 'REFCURSOR', proc_params);

      utassert.eq_refc_query (
         'Should return J2EE and SmallTalk',
         'TRAININGS.GET_COMPLETED_TRAININGS',
         proc_params,
         0,
         'select distinct training_name from training_results where training_name in (''J2EE'',''SmallTalk'')'
      );
   END;

END ut_trainings;
/

show err