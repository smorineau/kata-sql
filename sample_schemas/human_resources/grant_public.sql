Rem    NOTES
Rem
Rem    to be run by SYS or SYSTEM

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO OFF

/*
DROP PROCEDURE add_job_history;
DROP PROCEDURE secure_dml;

DROP VIEW emp_details_view;

DROP SEQUENCE departments_seq;
DROP SEQUENCE employees_seq;
DROP SEQUENCE locations_seq;
*/
grant all on hr.regions     to public;
grant all on hr.departments to public;
grant all on hr.locations   to public;
grant all on hr.jobs        to public;
grant all on hr.job_history to public;
grant all on hr.employees   to public;
grant all on hr.countries   to public;

