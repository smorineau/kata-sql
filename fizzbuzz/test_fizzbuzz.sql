set lines 120

@fizzbuzz.sql

@ut_fizzbuzz.pks
@ut_fizzbuzz.pkb

exec utplsql.test ('fizzbuzz', recompile_in => FALSE);

exit