create or replace package body TRAININGS
as

    function GET_COMPLETED_TRAININGS
    return sys_refcursor
    is
        COMPLETED_TRAININGS     sys_refcursor;
    BEGIN
        
        open COMPLETED_TRAININGS for
           select TRAINING_NAME
             from TRAINING_RESULTS
            group by TRAINING_NAME
           having count(*) = count(COMPLETION_DATE)
        ;

        /* Below query is also correct but the table is accessed twice
        select
               distinct training_name
          from TRAINING_RESULTS T1
         where not exists
               (select *
                  from TRAINING_RESULTS T2
                 where T1.training_name = T2.training_name
                   and T2.completion_date is null);
        */

        return COMPLETED_TRAININGS;

    END GET_COMPLETED_TRAININGS;

end TRAININGS;
/

show err
