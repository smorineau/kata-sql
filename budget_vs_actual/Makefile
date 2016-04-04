test: budget_vs_actual.pks budget_vs_actual.pkb ut_budget_vs_actual.pks ut_budget_vs_actual.pkb
	sqlplus utp/utp @test_budget_vs_actual.sql

setup: budget_vs_actual_setup.sql
		sqlplus utp/utp @budget_vs_actual_setup.sql

cleanup: budget_vs_actual_cleanup.sql
		sqlplus utp/utp @budget_vs_actual_cleanup.sql