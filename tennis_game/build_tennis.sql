set serveroutput on

@tennis_ddl.sql
@tennis.sql

@ut_tennis.sql

exec utplsql.test('tennis', recompile_in => FALSE);

exit