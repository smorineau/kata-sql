test: template_package.pks template_package.pkb ut_template_package.pks ut_template_package.pkb
	sqlplus ${DB_CONNECT_STRING} @build.sql

setup:
	sqlplus ${DB_CONNECT_STRING} @template_package_setup.sql

cleanup:
	sqlplus ${DB_CONNECT_STRING} @template_package_cleanup.sql
