create or replace package body hr_queries
as

   function get_employee_name(emp_id in &hr_user..employees.employee_id%type) return varchar2
   is
      employee_name    varchar2(45);
   begin
      select first_name || ' ' || last_name
        into employee_name
        from &hr_user..employees
       where employee_id = emp_id;

      return employee_name;
   end;

end;
/