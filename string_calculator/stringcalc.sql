create or replace package stringcalc
is
   function add(string in varchar2 default 0) return integer;
end stringcalc;
/

show err

create or replace package body stringcalc
is
   type integer_list is table of pls_integer;
   function parse_string(string in varchar2) return integer_list;
   function add_terms(terms in integer_list) return pls_integer;

   function parse_string(string in varchar2) return integer_list is
      
      terms             integer_list := integer_list();
      start_position    pls_integer := 1;
      next_separator_position   pls_integer;
   begin

      while true
      loop
         next_separator_position := instr(string, ',', start_position);
         exit when next_separator_position = 0;

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