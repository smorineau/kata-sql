test: tennis_ddl.sql tennis.sql
	sqlplus utp/utp @build_tennis.sql

setup: budget_vs_actual_setup.sql
		sqlplus utp/utp @budget_vs_actual_setup.sql

cleanup: budget_vs_actual_cleanup.sql
		sqlplus utp/utp @budget_vs_actual_cleanup.sql