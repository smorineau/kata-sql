test: hr_queries.pks hr_queries.pkb ut_hr_queries.pks ut_hr_queries.pkb
	sqlplus ${DB_CONNECT_STRING} @build.sql

setup:
	sqlplus ${DB_CONNECT_STRING} @hr_queries_setup.sql

cleanup:
	sqlplus ${DB_CONNECT_STRING} @hr_queries_cleanup.sql
