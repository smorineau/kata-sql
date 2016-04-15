test: stringcalc.pks stringcalc.sql ut_stringcalc.sql build_stringcalc.sql
	sqlplus ${DB_CONNECT_STRING} @build_stringcalc.sql

cleanup: roman_numerals_cleanup.sql
		sqlplus ${DB_CONNECT_STRING} @roman_numerals_cleanup.sql