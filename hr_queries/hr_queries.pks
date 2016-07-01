create or replace package hr_queries
as

   function get_employee_name(emp_id in &hr_user..employees.employee_id%type) return varchar2;

end;
/