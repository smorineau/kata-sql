create or replace package ut_numerals
is

   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;

   procedure ut_1_to_9;
   procedure ut_10_to_99;
   procedure ut_100_to_999;
   procedure ut_1000_to_3000;

end ut_numerals;
/

show err

create or replace package body ut_numerals
is

   PROCEDURE ut_setup IS
   BEGIN
      NULL;
   END;
   
   PROCEDURE ut_teardown
   IS
   BEGIN
      NULL;
   END;

   procedure ut_1_to_9 is
   begin
      utassert.eq('Should return III when given 3',
         numerals.arabic_to_roman(3),
         'III');

      utassert.eq('Should return IV when given 4',
         numerals.arabic_to_roman(4),
         'IV');

      utassert.eq('Should return V when given 5',
         numerals.arabic_to_roman(5),
         'V');

      utassert.eq('Should return VIII when given 8',
         numerals.arabic_to_roman(8),
         'VIII');

      utassert.eq('Should return VIII when given 9',
         numerals.arabic_to_roman(9),
         'IX');
   end;

   procedure ut_10_to_99 is
   begin
      utassert.eq('Should return X when given 10',
         numerals.arabic_to_roman(10),
         'X');

      utassert.eq('Should return XIII when given 13',
         numerals.arabic_to_roman(13),
         'XIII');

      utassert.eq('Should return XV when given 15',
         numerals.arabic_to_roman(15),
         'XV');

      utassert.eq('Should return XLIX when given 49',
         numerals.arabic_to_roman(49),
         'XLIX');

      utassert.eq('Should return LXXX when given 80',
         numerals.arabic_to_roman(80),
         'LXXX');

      utassert.eq('Should return XC when given 90',
         numerals.arabic_to_roman(90),
         'XC');
   end;

   procedure ut_100_to_999 is
   begin
      utassert.eq('Should return C when given 100',
         numerals.arabic_to_roman(100),
         'C');

      utassert.eq('Should return CC when given 200',
         numerals.arabic_to_roman(200),
         'CC');

      utassert.eq('Should return CD when given 400',
         numerals.arabic_to_roman(400),
         'CD');

      utassert.eq('Should return DI when given 501',
         numerals.arabic_to_roman(501),
         'DI');

      utassert.eq('Should return DCCC when given 800',
         numerals.arabic_to_roman(800),
         'DCCC');

      utassert.eq('Should return CM when given 900',
         numerals.arabic_to_roman(900),
         'CM');
   end;

   procedure ut_1000_to_3000 is
   begin
      utassert.eq('Should return M when given 1000',
         numerals.arabic_to_roman(1000),
         'M');

      utassert.eq('Should return MC when given 1100',
         numerals.arabic_to_roman(1100),
         'MC');

      utassert.eq('Should return MMM when given 3000',
         numerals.arabic_to_roman(3000),
         'MMM');

      utassert.eq('Should return MCMLXXIX when given 1979',
         numerals.arabic_to_roman(1979),
         'MCMLXXIX');

      utassert.eq('Should return MMXVI when given 2016',
         numerals.arabic_to_roman(2016),
         'MMXVI');

   end;

end ut_numerals;
/

show err