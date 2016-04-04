set lines 120

@budget_vs_actual.pks
@budget_vs_actual.pkb

@ut_budget_vs_actual.pks
@ut_budget_vs_actual.pkb

exec utplsql.test ('budget_vs_actual', recompile_in => FALSE);

exit