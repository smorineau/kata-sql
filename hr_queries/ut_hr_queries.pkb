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

end;
/