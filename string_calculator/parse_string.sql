create or replace procedure parse_string(string in varchar2) is
   --type integer_list is table of pls_integer;
   type integer_list is varray of pls_integer;
   terms             integer_list := integer_list();
   occurence         pls_integer := 1;
   start_position    pls_integer := 1;
begin
   while true
   loop 
      terms.extend;
      terms(terms.LAST) := substr(string,start_position, 
                                         case instr(string, ',', 1, occurence) when 0 then length(string) else instr(string, ',', 1, occurence) - start_position end
                                 );
      /*dbms_output.put_line(substr(string,start_position, 
                                         case instr(string, ',', 1, occurence) when 0 then length(string) else instr(string, ',', 1, occurence) - start_position end
        =                         ));*/

      start_position := instr(string, ',', 1, occurence) + 1;
      exit when instr(string, ',', 1, occurence) = 0;
      occurence := occurence + 1;
      
   end loop;

   dbms_output.put_line('Number of terms : ' || terms.count);
   for i in 1..terms.count
   loop 
      dbms_output.put_line('Term N°' || i || ' : ' || terms(i));
   end loop;

end;
/

show err