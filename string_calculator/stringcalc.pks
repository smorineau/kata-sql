create or replace package stringcalc
is
   function add(string in varchar2 default 0) return integer;
end stringcalc;
/

show err