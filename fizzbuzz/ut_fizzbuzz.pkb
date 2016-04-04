CREATE OR REPLACE PACKAGE BODY ut_fizzbuzz
IS
   PROCEDURE ut_setup IS
   BEGIN
      NULL;
   END;
   
   PROCEDURE ut_teardown IS
   BEGIN
      NULL;
   END;

   PROCEDURE ut_fizzbuzzme IS
   BEGIN
      utAssert.eq (
         'Should return Fizz for multiples of 3 but not multiple of 5',
         fizzbuzz.fizzbuzzme(
            integer_in => 3
         ),
         'Fizz'
      );

      utAssert.eq (
         'Should return Buzz for multiples of 5 but not multiple of 3',
         fizzbuzz.fizzbuzzme(
            integer_in => 5
         ),
         'Buzz'
      );

      utAssert.eq (
         'Should return FizzBuzz for multiples of 3 and 5',
         fizzbuzz.fizzbuzzme(
            integer_in => 15
         ),
         'FizzBuzz'
      );

      utAssert.eq (
         'Should return input when it is neither multiple of 3 or 5',
         fizzbuzz.fizzbuzzme(
            integer_in => 2
         ),
         2
      );

   END ut_fizzbuzzme;

   PROCEDURE ut_direct_display IS
   BEGIN
      utAssert.eq (
         'Should iterate as many times as specified in boundary parameters (ie. boundary_stop - boundary_start + 1)',
         fizzbuzz.direct_display(
            boundary_start => 2,
            boundary_stop => 17
         ),
         16
      );

      utAssert.eq (
         'Should iterate as many times as specified in boundary parameters (ie. boundary_stop - boundary_start + 1)',
         fizzbuzz.direct_display(
            boundary_start => 1,
            boundary_stop => 1
         ),
         1
      );

      utAssert.isNULL (
         'Should return NULL when boundary_start is NULL)',
         fizzbuzz.direct_display(
            boundary_start => NULL,
            boundary_stop => 17
         )
      );

      utAssert.isNULL (
         'Should return NULL when boundary_stop is NULL)',
         fizzbuzz.direct_display(
            boundary_start => 2,
            boundary_stop => NULL
         )
      );

      utAssert.isNULL (
         'Should return NULL when boundary_start > boundary_stop)',
         fizzbuzz.direct_display(
            boundary_start => 20,
            boundary_stop => 5
         )
      );

   END ut_direct_display;

END ut_fizzbuzz;
/

show err