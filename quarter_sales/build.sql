set lines 120
set serveroutput on
clear screen

@qtr_sales.pks
@qtr_sales.pkb

@ut_qtr_sales.pks
@ut_qtr_sales.pkb

exec utplsql.test ('qtr_sales', recompile_in => FALSE);

exit
