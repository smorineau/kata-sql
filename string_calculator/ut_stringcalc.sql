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
      utassert.eq('Should return 0 when given no argument',
         stringcalc.add,
         0);
      utassert.eq('Should return 0 when given ""',
         stringcalc.add(''),
         0);
      utassert.eq('Should return 0 when given null',
         stringcalc.add(null),
         0);
      utassert.eq('Should return 1 when given "1"',
         stringcalc.add('1'),
         1);
      utassert.eq('Should return 3 when given "1,2"',
         stringcalc.add(q'[1,2]'),
         3);
      utassert.eq('Should return 3 when given "1\n2"',
         --stringcalc.add('1'||chr(10)||'2'),
         stringcalc.add('1
2'),
         3);
      utassert.eq('Should return 6 when given "1,2,3"',
         stringcalc.add(q'[1,2,3]'),
         6);
      utassert.eq('Should return 6 when given "1,2\n3"',
         stringcalc.add('1,2'||chr(10)||'3'),
         6);
      utassert.eq('Should return 9 when given "4\n2,3"',
         stringcalc.add('4'||chr(10)||'2,3'),
         9);
      utassert.throws('Should return an exception (labeled "negatives not allowed : " + negative number) when given a negative number : "2n-2,3"',
         'declare output integer; begin output:=stringcalc.add(q''[2'||chr(10)||'-2,3]''); end;',
         -20001);
      utassert.eq('Should return 3 when given "2\n1001,1"',
         stringcalc.add('2'||chr(10)||'1001,1'),
         3);
      utassert.eq('Should return 5 when given "1001\n2,3"',
         stringcalc.add('1001'||chr(10)||'2,3'),
         5);
      utassert.eq('Should return 10 when given "1,2,3,4"',
         stringcalc.add(q'[1,2,3,4]'),
         10);
      utassert.eq('Should return 10 when given "//[*]\n1,2\n3*4"',
         stringcalc.add('//[*]'||chr(10)||'1,2'||chr(10)||'3*4'),
         10);
      utassert.eq('Should return 11 when given "//[***]\n2,2\n3***4"',
         stringcalc.add('//[***]'||chr(10)||'2,2'||chr(10)||'3***4'),
         11);
      utassert.eq('Should return 15 when given "//[***][ac][dc]\n2,2\n3***4ac3dc1"',
         stringcalc.add('//[***][ac][dc]'||chr(10)||'2,2'||chr(10)||'3***4ac3dc1'),
         15);
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