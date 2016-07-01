create or replace package ut_hr_queries
as

   procedure ut_setup;
   procedure ut_teardown;

   procedure ut_get_employee_name;
   procedure ut_get_employee_name_explicit;

end;
/