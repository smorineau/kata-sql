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
   -- step 4
   type employees_salary_details is record(
        first_name &hr_user..employees.first_name%type,
        last_name  &hr_user..employees.last_name%type,
        salary     &hr_user..employees.salary%type );
   type employees_salary is ref cursor return employees_salary_details;
   function get_sales_rep_salary_strong(salary_rank in varchar2) return employees_salary;
   -- step 5
   function get_sales_rep_salary_weak(salary_rank in varchar2) return sys_refcursor;
   -- step 6
   function get_emp_details(p_region_name in varchar2,
                            p_dept_name   in varchar2,
                            p_max_salary  in number) return sys_refcursor;

end;
/
