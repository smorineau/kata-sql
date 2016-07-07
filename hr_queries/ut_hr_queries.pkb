create or replace package body ut_hr_queries
as

   procedure ut_setup
   is
   begin
      null;
   end;

   procedure ut_teardown
   is
   begin
      null;
   end;

   procedure ut_get_employee_name
   is
   begin
      utassert.eq('Should return "Lex De Haan" when given 102',
                  hr_queries.get_employee_name(102),
                  'Lex De Haan');

      utassert.throws('Should return NO_DATA_FOUND when given 1',
                      'declare emp_name varchar2(45); begin emp_name:=hr_queries.get_employee_name(1); end;',
                      'NO_DATA_FOUND');

      utassert.throws('Should return TOO_MANY_ROWS when given 105',
                      'declare emp_name varchar2(45); begin emp_name:=hr_queries.get_employee_name(105); end;',
                      'TOO_MANY_ROWS');
   end;

   procedure ut_get_employee_name_explicit
   is
   begin
      utassert.eq('Should return "Lex De Haan" when given 102',
                  hr_queries.get_employee_name(102),
                  'Lex De Haan');

      utassert.throws('Should return NO_DATA_FOUND when given 1',
                      'declare emp_name varchar2(45); begin emp_name:=hr_queries.get_employee_name_explicit(1); end;',
                      'NO_DATA_FOUND');

      utassert.throws('Should return TOO_MANY_ROWS when given 105',
                      'declare emp_name varchar2(45); begin emp_name:=hr_queries.get_employee_name_explicit(105); end;',
                      'TOO_MANY_ROWS');
   end;

   procedure ut_get_it_employees
   is
      proc_params         utplsql_util.utplsql_params;
      expected_resultset  varchar2(1000);
   begin
      utplsql_util.reg_out_param (0, 'REFCURSOR', proc_params);

      expected_resultset := q'[
         select 'Alexander' as first_name,'Hunold'    as last_name,103 as employee_id from dual union all
         select 'Bruce'     as first_name,'Ernst'     as last_name,104 as employee_id from dual union all
         select 'David'     as first_name,'Austin'    as last_name,105 as employee_id from dual union all
         select 'Valli'     as first_name,'Pataballa' as last_name,106 as employee_id from dual union all
         select 'Diana'     as first_name,'Lorentz'   as last_name,107 as employee_id from dual union all
         select 'David'     as first_name,'Austin'    as last_name,105 as employee_id from dual
         ]';

      utassert.eq_refc_query (
         'Should return details for 6 IT employees',
         'hr_queries.get_it_employees',
         proc_params,
         0,
         expected_resultset
      );
   end;

end;
/