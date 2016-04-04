CREATE OR REPLACE PACKAGE fizzbuzz
AS

TYPE fizzbuzz_array IS VARRAY(100) OF VARCHAR2(8);

PROCEDURE display_fizzbuzz (fizzbuzz_in IN fizzbuzz_array);

FUNCTION direct_display(boundary_start IN PLS_INTEGER, boundary_stop IN PLS_INTEGER)
RETURN PLS_INTEGER;

FUNCTION build_fizzbuzz
RETURN fizzbuzz_array;

FUNCTION fizzbuzzme(integer_in IN INTEGER)
RETURN VARCHAR2;

END fizzbuzz;
/

show err

/*************************************/

CREATE OR REPLACE PACKAGE BODY fizzbuzz
AS

FUNCTION fizzbuzzme(integer_in IN INTEGER)
RETURN VARCHAR2
IS

fizzbuzz        VARCHAR2(8);

BEGIN

  fizzbuzz := NULL;

  IF MOD(integer_in,3) = 0
  THEN fizzbuzz:='Fizz';
  END IF;

  IF MOD(integer_in,5) = 0
  THEN fizzbuzz:=fizzbuzz||'Buzz';
  END IF;

  IF fizzbuzz is NULL
  THEN fizzbuzz := integer_in;
  END IF;

  RETURN fizzbuzz;

END fizzbuzzme;

/*************************************/

FUNCTION direct_display(boundary_start IN PLS_INTEGER, boundary_stop IN PLS_INTEGER)
RETURN PLS_INTEGER
IS
  nb_iteration        PLS_INTEGER := 0;

  FUNCTION is_boundary_invalid (boundary_start IN PLS_INTEGER, boundary_stop IN PLS_INTEGER)
    RETURN BOOLEAN
  IS
  BEGIN
    RETURN (boundary_start IS NULL) OR (boundary_stop IS NULL) OR (boundary_start > boundary_stop);
  END;

BEGIN

IF is_boundary_invalid (boundary_start, boundary_stop)
THEN RETURN NULL;
END IF;

FOR counter IN boundary_start..boundary_stop
LOOP
  DBMS_OUTPUT.PUT_LINE(fizzbuzzme(counter));
  nb_iteration := nb_iteration + 1;
END LOOP;

RETURN nb_iteration;

END direct_display;

/*************************************/

FUNCTION build_fizzbuzz
RETURN fizzbuzz_array
IS

fizzbuzz fizzbuzz_array := fizzbuzz_array();

BEGIN

FOR counter IN 1..100
LOOP
  fizzbuzz.EXTEND;
  fizzbuzz(counter) := fizzbuzzme(counter);

END LOOP;

RETURN fizzbuzz;

END build_fizzbuzz;

/*************************************/

PROCEDURE display_fizzbuzz (fizzbuzz_in IN fizzbuzz_array)
IS
  list_index PLS_INTEGER := fizzbuzz_in.FIRST;

BEGIN

LOOP
  EXIT WHEN list_index IS NULL;

  DBMS_OUTPUT.PUT_LINE(fizzbuzz_in(list_index));
  list_index := fizzbuzz_in.NEXT(list_index);

END LOOP;

END display_fizzbuzz;

END fizzbuzz;
/

show err

/*****************************************************************************/

CREATE OR REPLACE PROCEDURE fizzbuzz01
IS

fizzbuzz        VARCHAR2(8);

BEGIN

FOR counter IN 1..100
LOOP

  fizzbuzz := NULL;

  IF MOD(counter,3) = 0
  THEN fizzbuzz:='FIZZ';
  END IF;

  IF MOD(counter,5) = 0
  THEN fizzbuzz:=fizzbuzz||'BUZZ';
  END IF;

  IF fizzbuzz IS NULL
  THEN fizzbuzz := counter;
  END IF;

  DBMS_OUTPUT.PUT_LINE(fizzbuzz);
END LOOP;

END FIZZBUZZ01;
/