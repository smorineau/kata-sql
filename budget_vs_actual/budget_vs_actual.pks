CREATE OR REPLACE PACKAGE budget_vs_actual
AS

    FUNCTION compare_by_category(in_category IN PLS_INTEGER)
    RETURN SYS_REFCURSOR;

    FUNCTION get_categories_over_budget
    RETURN SYS_REFCURSOR;

END budget_vs_actual;
/

show err