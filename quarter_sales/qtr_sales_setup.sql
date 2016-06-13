CREATE TABLE quarter_sales (
COUNTRY                       VARCHAR2(20 CHAR),
Q1_AMOUNT                     NUMBER(6),
Q2_AMOUNT                     NUMBER(6),
Q3_AMOUNT                     NUMBER(6),
Q4_AMOUNT                     NUMBER(6)
);

CREATE TABLE year_sales_low (
COUNTRY                       VARCHAR2(20 CHAR),
YEAR_AMOUNT                   NUMBER(6)
);

CREATE TABLE year_sales_medium (
COUNTRY                       VARCHAR2(20 CHAR),
YEAR_AMOUNT                   NUMBER(6)
);

CREATE TABLE year_sales_high (
COUNTRY                       VARCHAR2(20 CHAR),
YEAR_AMOUNT                   NUMBER(6)
);
