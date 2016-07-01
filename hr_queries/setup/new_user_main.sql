SET ECHO OFF
SET VERIFY OFF
--utp/utp@sebora12/sebora12
--@new_user_main.sql RH RH SYSTEM TEMP SYS oracle sebora12/sebora12
PROMPT
PROMPT specify name for new user as parameter 1:
DEFINE user_name = &1
PROMPT
PROMPT specify password for &user_name. as parameter 2:
DEFINE pass      = &2
PROMPT
PROMPT specify default tablespace for &user_name. as parameter 3:
DEFINE tbs       = &3
PROMPT
PROMPT specify temporary tablespace for &user_name. as parameter 4:
DEFINE ttbs      = &4
PROMPT
PROMPT specify name for the superuser as parameter 5:
DEFINE name_sys  = &5
PROMPT
PROMPT specify password for the superuser as parameter 6:
DEFINE pass_sys  = &6
PROMPT
PROMPT specify connect string as parameter 7:
DEFINE connect_string = &7
PROMPT

-- The first dot in the spool command below is
-- the SQL*Plus concatenation character

DEFINE spool_file = hr_main.log
SPOOL &spool_file

REM =======================================================
REM cleanup section
REM =======================================================

DROP USER &user_name. CASCADE;

REM =======================================================
REM create user
REM three separate commands, so the create user command
REM will succeed regardless of the existence of the
REM DEMO and TEMP tablespaces
REM =======================================================

CREATE USER &user_name. IDENTIFIED BY &pass;

ALTER USER &user_name. DEFAULT TABLESPACE &tbs
              QUOTA UNLIMITED ON &tbs;

ALTER USER &user_name. TEMPORARY TABLESPACE &ttbs;

GRANT CREATE SESSION, CREATE VIEW, ALTER SESSION, CREATE SEQUENCE TO &user_name.;
GRANT CREATE SYNONYM, CREATE DATABASE LINK, RESOURCE , UNLIMITED TABLESPACE TO &user_name.;

REM =======================================================
REM grants from &name_sys. schema
REM =======================================================

CONNECT &name_sys./&pass_sys@&connect_string;
GRANT execute ON SYS.dbms_stats TO &user_name.;

REM =======================================================
REM create &user_name. schema objects
REM =======================================================

CONNECT &user_name./&pass@&connect_string
ALTER SESSION SET NLS_LANGUAGE=American;
ALTER SESSION SET NLS_TERRITORY=America;

--
-- create tables, sequences and constraint
--

@hr_cre

--
-- populate tables
--

@hr_popul

--
-- create indexes
--

@hr_idx

--
-- create procedural objects
--

@hr_code

--
-- add comments to tables and columns
--

@hr_comnt

--
-- gather schema statistics
--

@hr_analz

spool off
