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

   function get_employee_name_explicit(emp_id in &hr_user..employees.employee_id%type) return varchar2
   is
      cursor c_get_employee_name is
      select first_name || ' ' || last_name
        from &hr_user..employees
       where employee_id = emp_id;

      employee_name    varchar2(45);
   begin
      open c_get_employee_name;
      fetch c_get_employee_name into employee_name;
      if c_get_employee_name%notfound  then
         raise no_data_found;
      end if;
      fetch c_get_employee_name into employee_name;
      if c_get_employee_name%found  then
         raise too_many_rows;
      end if;
      close c_get_employee_name;

      return employee_name;
   end;

end;
/