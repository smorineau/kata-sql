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
   end;

end;
/