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

   function get_it_employees return sys_refcursor
   is
      it_employees       sys_refcursor;
   begin
      open it_employees for
           select
                  emp.first_name,
                  emp.last_name,
                  emp.employee_id
             from
                  &hr_user..employees   emp JOIN
                  &hr_user..departments dep ON (emp.department_id = dep.department_id)
            where
                  dep.department_name = 'IT'
           ;
      return it_employees;
   end;

   procedure display_it_employees
   is
      it_employees       sys_refcursor;
      type employees_details is record(
         first_name &hr_user..employees.first_name%type,
         last_name &hr_user..employees.last_name%type,
         emp_id &hr_user..employees.employee_id%type );
      it_employees_rec   employees_details;

      function boolean_to_string(bool in boolean) return varchar2
      is
      begin
         if bool then return 'TRUE'; else return 'FALSE'; end if;
      end;

   begin
      dbms_output.put_line('---------------------');
      dbms_output.put_line('display_it_employees');
      dbms_output.put_line('---------------------');
      dbms_output.put_line('==> it_employees%isopen : ' || boolean_to_string(it_employees%isopen) );
      it_employees := get_it_employees;
      dbms_output.put_line('==> it_employees%isopen : ' || boolean_to_string(it_employees%isopen) );
      dbms_output.put_line('==> it_employees%found : ' || boolean_to_string(it_employees%found) );
      dbms_output.put_line('==> it_employees%rowcount : ' || it_employees%rowcount );
      loop
         fetch it_employees into it_employees_rec ;
         dbms_output.put_line('==> it_employees%found : ' || boolean_to_string(it_employees%found) );
         dbms_output.put_line('==> it_employees%rowcount : ' || it_employees%rowcount );
         exit when it_employees%notfound;
         dbms_output.put_line(it_employees_rec.emp_id || ' , ' || it_employees_rec.first_name || ' , ' || it_employees_rec.last_name);
      end loop;
      close it_employees;
   end;

end;
/