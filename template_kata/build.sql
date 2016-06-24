clear screen

@template_package.pks
show err
@ut_template_package.pks
show err

@template_package.pkb
show err
@ut_template_package.pkb
show err

set serveroutput on

exec utplsql.test ('template_package', recompile_in => FALSE);

exit