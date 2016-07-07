create or replace package hr_queries
as

   -- step 1
   function get_employee_name(emp_id in &hr_user..employees.employee_id%type) return varchar2;
   function get_employee_name_explicit(emp_id in &hr_user..employees.employee_id%type) return varchar2;
   -- step 2
   procedure display_shipping_employees;
   procedure display_shipping_employees2;
   -- step 3
   function get_it_employees return sys_refcursor;
   procedure display_it_employees;

end;
/