cd to the human_resources directory
connect to sqlplus with user SYS

````
docker run -it -v $(pwd):/sql-src --rm --link sebora12:sebora12 oracli:12 sql+
connect sys/oracle@sebora12/sebora12 as sysdba
````

run the hr_main.sql script with appropriate arguments:

````
@hr_main.sql HR SYSTEM TEMP oracle sebora12/sebora12
````
