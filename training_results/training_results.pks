create or replace package TRAININGS
as

    function GET_COMPLETED_TRAININGS
    return sys_refcursor;

end TRAININGS;
/

show err