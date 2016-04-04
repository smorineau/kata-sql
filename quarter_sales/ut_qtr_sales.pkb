CREATE OR REPLACE PACKAGE BODY ut_qtr_sales
AS

   PROCEDURE ut_setup IS
   BEGIN

      EXECUTE IMMEDIATE 'TRUNCATE TABLE quarter_sales';

      INSERT INTO quarter_sales VALUES ('PORTUGAL',52  , 54  , 34  , 61);
      INSERT INTO quarter_sales VALUES ('SPAIN'   ,105 , 223 , 152 , 287);
      INSERT INTO quarter_sales VALUES ('ITALY'   ,138 , 234 , 209 , 256);
      INSERT INTO quarter_sales VALUES ('FRANCE'  ,210 , 250 , 201 , 303);
      INSERT INTO quarter_sales VALUES ('UK'      ,1022, 1394, 1232, 2161);

      EXECUTE IMMEDIATE 'TRUNCATE TABLE year_sales_low';
      EXECUTE IMMEDIATE 'TRUNCATE TABLE year_sales_medium';
      EXECUTE IMMEDIATE 'TRUNCATE TABLE year_sales_high';

      EXECUTE IMMEDIATE 'CREATE TABLE ut_year_sales_low    AS SELECT * FROM year_sales_low';
      EXECUTE IMMEDIATE 'CREATE TABLE ut_year_sales_medium AS SELECT * FROM year_sales_medium';
      EXECUTE IMMEDIATE 'CREATE TABLE ut_year_sales_high   AS SELECT * FROM year_sales_high';

   END;

   PROCEDURE ut_teardown IS
   BEGIN

      EXECUTE IMMEDIATE 'DROP TABLE ut_year_sales_low';
      EXECUTE IMMEDIATE 'DROP TABLE ut_year_sales_medium';
      EXECUTE IMMEDIATE 'DROP TABLE ut_year_sales_high';

   END;

   PROCEDURE ut_load_year_sales IS
   BEGIN


      EXECUTE IMMEDIATE 'INSERT INTO ut_year_sales_low    VALUES (''PORTUGAL'',201)';
      EXECUTE IMMEDIATE 'INSERT INTO ut_year_sales_medium VALUES (''SPAIN'',767)';
      EXECUTE IMMEDIATE 'INSERT INTO ut_year_sales_medium VALUES (''ITALY'',837)';
      EXECUTE IMMEDIATE 'INSERT INTO ut_year_sales_medium VALUES (''FRANCE'',964)';
      EXECUTE IMMEDIATE 'INSERT INTO ut_year_sales_high   VALUES (''UK'',5809)';

      qtr_sales.load_year_sales;

      utAssert.eqtable (
         msg_in           => 'Insert into year_sales_low',
         check_this_in    => 'year_sales_low',
         against_this_in  => 'ut_year_sales_low'
      );

      utAssert.eqtable (
         msg_in           => 'Insert into year_sales_medium',
         check_this_in    => 'year_sales_medium',
         against_this_in  => 'ut_year_sales_medium'
      );

      utAssert.eqtable (
         msg_in           => 'Insert into year_sales_high',
         check_this_in    => 'year_sales_high',
         against_this_in  => 'ut_year_sales_high'
      );

   END;
   
END ut_qtr_sales;
/

show err
