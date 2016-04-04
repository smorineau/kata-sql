create or replace package numerals
is
   function arabic_to_roman(arabic in integer) return varchar2;
   procedure show_decomp(arabic in integer);
end numerals;
/

show err

create or replace package body numerals
is

   ONE          constant char(1) := 'I';
   FIVE         constant char(1) := 'V';
   TEN          constant char(1) := 'X';
   FIFTY        constant char(1) := 'L';
   HUNDRED      constant char(1) := 'C';
   FIVEHUNDRED  constant char(1) := 'D';
   THOUSAND     constant char(1) := 'M';

   TYPE decimal_array IS VARRAY(4) of integer;

   function convert_to_roman(decimal_decomposed in decimal_array) return varchar2;
   function decompose_decimal(decimal_int in integer) return decimal_array;
   function repeat_string(roman in char, nb_repetitions in integer) return varchar2;
   function convert_units(arabic in integer) return varchar2;
   function convert_tens(arabic in integer) return varchar2;
   function convert_hundreds(arabic in integer) return varchar2;
   function convert_thousands(arabic in integer) return varchar2;

   function arabic_to_roman(arabic in integer) return varchar2
   is
   begin
      return convert_to_roman(decompose_decimal(arabic));
   end arabic_to_roman;

   function convert_to_roman(decimal_decomposed in decimal_array) return varchar2
   is
      exponent       integer := null;
      roman_string  varchar2(50) := null;
   begin
      exponent := decimal_decomposed.first;
      while exponent is not null loop
         if exponent - 1 = 0 then roman_string := convert_units(decimal_decomposed(exponent)); end if;
         if exponent - 1 = 1 then roman_string := convert_tens(decimal_decomposed(exponent)) || roman_string; end if;
         if exponent - 1 = 2 then roman_string := convert_hundreds(decimal_decomposed(exponent)) || roman_string; end if;
         if exponent - 1 = 3 then roman_string := convert_thousands(decimal_decomposed(exponent)) || roman_string; end if;
         exponent := decimal_decomposed.next(exponent);
      end loop;
      return roman_string;
   end;

   function decompose_decimal(decimal_int in integer) return decimal_array
   is
      decimal_decomposed    decimal_array:=decimal_array();
      num                   integer := decimal_int;
   begin

      while num > 0 loop
         decimal_decomposed.extend;
         decimal_decomposed(decimal_decomposed.last) := mod(num, 10);
         num := trunc(num / 10);
      end loop;

      return decimal_decomposed;
   end;

   procedure show_decomp(arabic in integer)
   is
      decimal_decomposed    decimal_array:=decimal_array();
      idx   integer := null;
   begin
      dbms_output.put_line('show_decomp');
      decimal_decomposed:=decompose_decimal(arabic);
      idx := decimal_decomposed.first;
      while idx is not null loop
         dbms_output.put_line('index : ' || idx || ' - value : ' || decimal_decomposed(idx));
         idx := decimal_decomposed.next(idx);
      end loop;
   end;

   function repeat_string(roman in char, nb_repetitions in integer) return varchar2
   is
      string    varchar2(3) := null;
   begin

      for i in 1..nb_repetitions
      loop
         string := string || roman;
      end loop;

      return string;
   end;


   function convert_units(arabic in integer) return varchar2
   is
   begin

      case when arabic between 1 and  3 then return repeat_string(ONE,arabic);
           when arabic = 4 then return ONE || FIVE;
           when arabic = 5 then return FIVE;
           when arabic between 6 and 8 then return FIVE || repeat_string(ONE,arabic - 5);
           when arabic = 9 then return ONE || TEN;
           else return null;
      end case;

   end convert_units;

   function convert_tens(arabic in integer) return varchar2
   is
   begin

      case when arabic between 1 and  3 then return repeat_string(TEN,arabic);
           when arabic = 4 then return TEN || FIFTY;
           when arabic = 5 then return FIFTY;
           when arabic between 6 and 8 then return FIFTY || repeat_string(TEN,arabic - 5);
           when arabic = 9 then return TEN || HUNDRED;
           else return null;
      end case;

   end convert_tens;

   function convert_hundreds(arabic in integer) return varchar2
   is
   begin

      case when arabic between 1 and  3 then return repeat_string(HUNDRED,arabic);
           when arabic = 4 then return HUNDRED || FIVEHUNDRED;
           when arabic = 5 then return FIVEHUNDRED;
           when arabic between 6 and 8 then return FIVEHUNDRED || repeat_string(HUNDRED,arabic - 5);
           when arabic = 9 then return HUNDRED || THOUSAND;
           else return null;
      end case;

   end convert_hundreds;

   function convert_thousands(arabic in integer) return varchar2
   is
   begin

      case when arabic between 1 and  3 then return repeat_string(THOUSAND,arabic);
           else return null;
      end case;

   end convert_thousands;

end numerals;
/

show err