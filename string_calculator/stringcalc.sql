create or replace package body stringcalc
is
   type integer_list is table of pls_integer;
   --type separator_list is table of varchar2(100);

   type separator_details is record (value varchar2(100), next_position pls_integer);
   type separator_list is table of separator_details;

   function parse_string(string in varchar2, in_separators in separator_list) return integer_list;
   function add_terms(terms in integer_list) return pls_integer;

   procedure check_terms_for_negative(terms in integer_list) is
   begin
      for i in terms.FIRST..terms.LAST
      loop
         if terms(i)<0 then raise_application_error(-20001,'negative not allowed : ' || to_char(terms(i))); end if;
      end loop;
   end;

   function remove_user_separators(string in varchar2) return varchar2 is
      l_string       varchar2(4000) := string;
   begin
      if substr(string,1,2) = '//' then
         l_string := substr(string, instr(string, chr(10)) + 1);
      end if;
      dbms_output.put_line('remove_user_separators, string:'||l_string||'end');
      return l_string;
   end;

   function get_user_separators(string in varchar2) return separator_list is
      current_position              pls_integer := 1;
      start_separator_delimiter     constant char(1) := '[';
      end_separator_delimiter       constant char(1) := ']';
      start_separator_position      pls_integer;
      end_separator_position        pls_integer;
      separator                     separator_details;
      separators                    separator_list := separator_list();
   begin
        dbms_output.put_line('get_user_separators');
--      while true loop
         start_separator_position := instr(string,start_separator_delimiter,current_position) + 1;
         end_separator_position := instr(string,end_separator_delimiter,current_position);
         separator.value := substr(string, start_separator_position, end_separator_position - start_separator_position);
--         separator.length := length(separator.value);
         separators.extend;
         separators(separators.last) := separator;
         current_position := end_separator_position + 1;
--         exit when substr(string, current_position, 1) = chr(10);
         if substr(string, current_position, 1) = chr(10) then dbms_output.put_line('would exit here'); end if;
--      end loop;
         return separators;
   end;

   function get_separators(string in varchar2) return separator_list is
      separators    separator_list := separator_list();
      separator     separator_details;
   begin
      dbms_output.put_line('get_separators');
      -- user-specified separators
      if substr(string,1,2) = '//' then
         --dbms_output.put_line('user separators');
         --separators.extend;
         --separators(separators.last) := get_user_separators(string);
         separators := get_user_separators(string);
         dbms_output.put_line('user separators : ' || separators(separators.last).value);
      end if;
      --dbms_output.put_line('user separators : ' || separators(separators.last).value);

      -- default separators
      separator.value := ',';
--      separator.length := length(separator.value);
      separators.extend;
      separators(separators.last) := separator;

      separator.value := chr(10);
 --     separator.length := length(separator.value);
      separators.extend;
      separators(separators.last) := separator;

      return separators;
   end;

   function get_separator_details(string in varchar2, start_position in pls_integer, separators in separator_list) return separator_details is
      --next_separator_position   pls_integer := length(string);
      separator_position        pls_integer := 0;
      separator                 separator_details;
   begin
      separator.next_position := length(string);
      for i in separators.FIRST..separators.LAST
      loop
         dbms_output.put_line('get_separator_details loop, separators(i).value : ' || separators(i).value);
         separator_position := instr(string, separators(i).value, start_position);
         dbms_output.put_line('before if');
         if separator_position <> 0 and separator_position < separator.next_position then
            dbms_output.put_line('get_separator_details : in then');
            separator.next_position := separator_position;
            separator.value := separators(i).value;
         end if;
      end loop;
      dbms_output.put_line('get_separator_details : before return');
      return separator;
   end;

   function parse_string(string in varchar2, in_separators in separator_list) return integer_list is

      terms                     integer_list := integer_list();
      start_position            pls_integer := 1;
      separators                separator_list:= in_separators;
      separator                 separator_details;
   begin

      while true
      loop
         dbms_output.put_line('while true loop');
         separator := get_separator_details(string, start_position, separators);
         exit when separator.next_position = length(string);
         dbms_output.put_line('parse_string, separator.value : ' || separator.value);

         terms.extend;
         terms(terms.LAST) := substr(string, start_position, separator.next_position - start_position);
         start_position := separator.next_position + length(separator.value);
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
      dbms_output.put_line('end of string');
      if string is null then return terms_sum; end if;
      terms := parse_string(remove_user_separators(string), get_separators(string));
      check_terms_for_negative(terms);
      terms_sum := add_terms(remove_terms_bigger_1000(terms));
      return terms_sum;
   end add;

end stringcalc;
/

show err