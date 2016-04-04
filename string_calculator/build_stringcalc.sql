set serveroutput on
set lines 120

@stringcalc.sql

@ut_stringcalc.sql

--exec utresult.ignore_successes;
exec utplsql.test('stringcalc', recompile_in => FALSE);

exit