clear screen

define hr_user=HR

@hr_queries.pks
show err
@ut_hr_queries.pks
show err

@hr_queries.pkb
show err
@ut_hr_queries.pkb
show err

set serveroutput on

exec utplsql.test ('hr_queries', recompile_in => FALSE);

exit