set serveroutput on
set lines 120

@roman_numerals.sql

@ut_roman_numerals.sql

exec utresult.ignore_successes;
exec utplsql.test('numerals', recompile_in => FALSE);

exit