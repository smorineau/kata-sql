create or replace package stringcalc
is
   function add(string in varchar2 default 0) return integer;
end stringcalc;
/

show err

create or replace package body stringcalc
is
   type integer_list is table of pls_integer;
   type separator_list is table of varchar2(1);
   function parse_string(string in varchar2) return integer_list;
   function add_terms(terms in integer_list) return pls_integer;

   procedure check_terms_for_negative(terms in integer_list) is
   begin 
      for i in terms.FIRST..terms.LAST
      LOOP
         if terms(i)<0 then raise_application_error(-20001,'negative not allowed : ' || to_char(terms(i))); end if;
      END LOOP;
   end;

   function get_separators return separator_list is
      separators    separator_list;
   begin
      separators:=separator_list(',','n');
      return separators;
   end;

   function get_next_separator_position(string in varchar2, start_position in pls_integer) return pls_integer is
      next_separator_position   pls_integer := length(string);
      separator_position        pls_integer := 0;
      separators                separator_list:=separator_list();
   begin
      separators := get_separators;
      for i in separators.FIRST..separators.LAST
      loop
         separator_position := instr(string, separators(i), start_position);
         if separator_position <> 0 and separator_position < next_separator_position then next_separator_position := separator_position; end if;
      end loop;
      return next_separator_position;
   end;

   function parse_string(string in varchar2) return integer_list is

      terms             integer_list := integer_list();
      start_position    pls_integer := 1;
      next_separator_position   pls_integer;
   begin

      while true
      loop
         next_separator_position := get_next_separator_position(string, start_position);
         exit when next_separator_position = length(string);

         terms.extend;
         terms(terms.LAST) := substr(string, start_position, next_separator_position - start_position);
         start_position := next_separator_position + 1;
      end loop;

      terms.extend;
      terms(terms.LAST) := substr(string, start_position, length(string) - start_position + 1);

      return terms;

   end;

   function remove_terms_bigger_1000(terms in integer_list) return integer_list
   is
       terms_lower_1001      integer_list := terms;
       i                     pls_integer := terms.FIRST;
   begin
      while i is not null loop
         if terms_lower_1001(i) > 1000 then terms_lower_1001.delete(i); end if;
         i := terms_lower_1001.next(i);
      end loop;
      return terms_lower_1001;
   end;

   function add_terms(terms in integer_list) return pls_integer
   is
      terms_sum         pls_integer := 0;
      i                 pls_integer := terms.first;
   begin
      while i is not null loop
         dbms_output.put_line('term'||i||' : ' || terms(i));
         terms_sum := terms_sum + terms(i);
         i := terms.next(i);
      end loop;
      return terms_sum;
   end;

   function add(string in varchar2 default 0) return integer
   is
      terms             integer_list := integer_list();
      terms_sum         pls_integer := 0;
   begin
      dbms_output.put_line('******************************');
      dbms_output.put_line('string : ' || string);
      if string is null then return terms_sum; end if;
      terms := parse_string(string);
      check_terms_for_negative(terms);
      terms_sum := add_terms(remove_terms_bigger_1000(terms));
      return terms_sum;
   end add;

end stringcalc;
/

show err