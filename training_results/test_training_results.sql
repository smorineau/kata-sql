set lines 120

@training_results.pks
@training_results.pkb

@ut_training_results.pks
@ut_training_results.pkb

exec utplsql.test ('trainings', recompile_in => FALSE);

exit
