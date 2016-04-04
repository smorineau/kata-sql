CREATE OR REPLACE PACKAGE BODY budget_vs_actual
AS

    FUNCTION compare_by_category(in_category IN PLS_INTEGER)
    RETURN SYS_REFCURSOR
    IS
        amounts_by_category     SYS_REFCURSOR;
    begin

        OPEN amounts_by_category FOR
        select
               category,
               sum(budgeted_cost) as budgeted_cost,
               sum(actual_cost)   as actual_cost
          from
               (
               select
                      category,
                      budgeted_cost,
                      cast( 0 as number(10,2) ) as actual_cost
                 from BUDGET
                where category = in_category
               UNION ALL
               select
                      category,
                      cast( 0 as number(10,2) ) as budgeted_cost,
                      actual_cost
                 from BUDGET B, ACTUAL A
                where B.project = A.project
                  and B.category = in_category
                )
        group by
        category
        ;

/*
        --> 2 in-line views
        
        select
               B.category as category,
               budgeted_cost,
               actual_cost
          from
               (
               select
                      category,
                      sum(budgeted_cost) as budgeted_cost
                 from BUDGET
                group by category
               ) B,
               (
               select
                      category,
                      sum(actual_cost) as actual_cost
                 from BUDGET B, ACTUAL A
                where B.project = A.project
                group by category
                ) A
          where
                B.category = A.category(+)
        ;
*/

        RETURN amounts_by_category;

    end compare_by_category;

    FUNCTION get_categories_over_budget
    RETURN SYS_REFCURSOR
    IS
        categories_over_budget     SYS_REFCURSOR;
    begin

        OPEN categories_over_budget FOR
        select
               category
          from
               (
               select
                      category,
                      budgeted_cost,
                      cast( 0 as number(10,2) ) as actual_cost
                 from BUDGET
               UNION ALL
               select
                      category,
                      cast( 0 as number(10,2) ) as budgeted_cost,
                      actual_cost
                 from BUDGET B, ACTUAL A
                where B.project = A.project
                )
        group by
        category
        having sum(actual_cost) >= sum(budgeted_cost)
        ;

        RETURN categories_over_budget;

    end get_categories_over_budget;

END budget_vs_actual;
/

show err