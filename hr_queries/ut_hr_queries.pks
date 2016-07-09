create or replace package ut_hr_queries
as

   procedure ut_setup;
   procedure ut_teardown;

   -- step 1
   procedure ut_get_employee_name;
   procedure ut_get_employee_name_explicit;
   -- step 3
   procedure ut_get_it_employees;
   -- step 6
   procedure ut_get_emp_details;

end;
/