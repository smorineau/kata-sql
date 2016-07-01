rem
rem Header: hr_main.sql 2015/03/19 10:23:26 smtaylor Exp $
rem
rem Copyright (c) 2001, 2015, Oracle and/or its affiliates.  All rights reserved. 
rem Owner  : ahunold
rem
rem NAME
rem   hr_main.sql - Main script for HR schema
rem
rem DESCRIPTON
rem   HR (Human Resources) is the smallest and most simple one 
rem   of the Sample Schemas
rem   

SET ECHO OFF
SET VERIFY OFF
--utp/utp@sebora12/sebora12
--@hr_main.sql HR SYSTEM TEMP oracle sebora12/sebora12
PROMPT

-- The first dot in the spool command below is 
-- the SQL*Plus concatenation character

DEFINE spool_file = hr_main.log
SPOOL &spool_file

REM =======================================================
REM create hr schema objects
REM =======================================================

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


 create procedural objects


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
