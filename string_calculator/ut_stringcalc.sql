create or replace package ut_stringcalc
is

   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;

   procedure ut_add;

end ut_stringcalc;
/

show err

create or replace package body ut_stringcalc
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

   procedure ut_add is
   begin
      utassert.eq('Should return 1 when given "1"',
         stringcalc.add('1'),
         1);
      utassert.eq('Should return 3 when given "1,2"',
         stringcalc.add(q'[1,2]'),
         3);
      utassert.eq('Should return 6 when given "1,2,3"',
         stringcalc.add(q'[1,2,3]'),
         6);
      utassert.eq('Should return 6 when given "1,2n3"',
         stringcalc.add(q'[1,2n3]'),
         6);
      utassert.eq('Should return 3 when given "1n2"',
         stringcalc.add('1n2'),
         3);
      utassert.eq('Should return 0 when given ""',
         stringcalc.add(''),
         0);
      utassert.eq('Should return 0 when given null',
         stringcalc.add(null),
         0);
      utassert.eq('Should return 0 when given no argument',
         stringcalc.add,
         0);

   end;

   procedure ut_neg is
   begin
      utassert.eq('Should return 1 when given "1"',
         stringcalc.add('1'),
         1);
   end;

end ut_stringcalc;
/

show err