DB-CONNECT-STRING=@sebora12/sebora12

test: roman_numerals.sql ut_roman_numerals.sql build_roman_numerals.sql
	sqlplus utp/utp$(DB-CONNECT-STRING) @build_roman_numerals.sql

setup: roman_numerals_setup.sql
		sqlplus utp/utp$(DB-CONNECT-STRING) @roman_numerals_setup.sql

cleanup: roman_numerals_cleanup.sql
		sqlplus utp/utp$(DB-CONNECT-STRING) @roman_numerals_cleanup.sql