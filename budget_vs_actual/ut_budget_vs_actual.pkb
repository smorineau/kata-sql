CREATE OR REPLACE PACKAGE BODY ut_budget_vs_actual
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

   PROCEDURE ut_compare_by_category
   IS

      PROCEDURE category_5100
      IS
         proc_params   utplsql_util.utplsql_params;
      BEGIN
         utplsql_util.reg_out_param (0, 'REFCURSOR', proc_params);
         utplsql_util.reg_in_param (1, 5100, proc_params);
   
         utassert.eq_refc_query (
            'Should return BUDGETED_COST=265 and ACTUAL_COST=164 for CATEGORY 5100',
            'budget_vs_actual.compare_by_category',
            proc_params,
            0,
            'select cast(5100 as number(38)) as CATEGORY, cast(265 as NUMBER(10,2)) as BUDGETED_COST, cast(164 as NUMBER(10,2)) as ACTUAL_COST from dual'
         );
      END category_5100;

      PROCEDURE category_5200
      IS
         proc_params   utplsql_util.utplsql_params;
      BEGIN
         utplsql_util.reg_out_param (0, 'REFCURSOR', proc_params);
         utplsql_util.reg_in_param (1, 5200, proc_params);
   
         utassert.eq_refc_query (
            'Should return BUDGETED_COST=99.9 and ACTUAL_COST=99.9 for CATEGORY 5200',
            'budget_vs_actual.compare_by_category',
            proc_params,
            0,
            'select cast(5200 as number(38)) as CATEGORY, cast(99.9 as NUMBER(10,2)) as BUDGETED_COST, cast(99.9 as NUMBER(10,2)) as ACTUAL_COST from dual'
         );
      END category_5200;

      PROCEDURE category_5300
      IS
         proc_params   utplsql_util.utplsql_params;
      BEGIN
         utplsql_util.reg_out_param (0, 'REFCURSOR', proc_params);
         utplsql_util.reg_in_param (1, 5300, proc_params);
   
         utassert.eq_refc_query (
            'Should return BUDGETED_COST=130 and ACTUAL_COST=0 for CATEGORY 5300',
            'budget_vs_actual.compare_by_category',
            proc_params,
            0,
            'select cast(5300 as number(38)) as CATEGORY, cast(130 as NUMBER(10,2)) as BUDGETED_COST, cast(0 as NUMBER(10,2)) as ACTUAL_COST from dual'
         );
      END category_5300;

   BEGIN

      category_5100;
      category_5200;
      category_5300;

   END;

   PROCEDURE ut_get_categories_over_budget
   IS
      proc_params   utplsql_util.utplsql_params;
   BEGIN
      utplsql_util.reg_out_param (0, 'REFCURSOR', proc_params);
      
      utassert.eq_refc_query (
        'Should return CATEGORIES 5200 and 5400',
        'budget_vs_actual.get_categories_over_budget',
        proc_params,
        0,
        'select CATEGORY from BUDGET where CATEGORY in (5200,5400)'
      );
   END ut_get_categories_over_budget;

END ut_budget_vs_actual;
/

show err