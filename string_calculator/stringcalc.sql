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


   function add_terms(terms in integer_list) return pls_integer
   is
      terms_sum         pls_integer := 0;
   begin
      for i in 1..terms.COUNT loop
         terms_sum := terms_sum + terms(i);
      end loop;
      return terms_sum;
   end;

   function add(string in varchar2 default 0) return integer
   is
      terms             integer_list := integer_list();
      terms_sum         pls_integer := 0;
   begin
      if string is null then return terms_sum; end if;
      terms := parse_string(string);
      terms_sum := add_terms(terms);
      return terms_sum;
   end add;

end stringcalc;
/

show err