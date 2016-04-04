CREATE OR REPLACE PACKAGE BODY qtr_sales
AS

   PROCEDURE load_year_sales IS
   BEGIN

      INSERT ALL
      WHEN (q1_amount + q2_amount + q3_amount + q4_amount <= 500) THEN
        INTO year_sales_low VALUES (country,
                                    q1_amount + q2_amount + q3_amount + q4_amount)
      WHEN (q1_amount + q2_amount + q3_amount + q4_amount > 500 AND q1_amount + q2_amount + q3_amount + q4_amount <= 1000) THEN
        INTO year_sales_medium VALUES (country,
                                       q1_amount + q2_amount + q3_amount + q4_amount)
      WHEN (q1_amount + q2_amount + q3_amount + q4_amount > 1000) THEN
        INTO year_sales_high VALUES (country,
                                     q1_amount + q2_amount + q3_amount + q4_amount)
      SELECT
             country,
             q1_amount,
             q2_amount,
             q3_amount,
             q4_amount
        FROM
             quarter_sales
      ;

   END load_year_sales;

END qtr_sales;
/

show err