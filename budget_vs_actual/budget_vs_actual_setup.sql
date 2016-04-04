drop table ACTUAL;
drop table BUDGET;

create table BUDGET
(project		integer			not null,
 category		integer			not null,
 budgeted_cost	number(10,2)	not null
);
 
alter table BUDGET
add constraint PK_BUDGET primary key (project);

create table ACTUAL
(exp_voucher	integer			not null,
 project		integer			not null,
 actual_cost	number(10,2)	not null
);

alter table ACTUAL
add constraint PK_ACTUAL primary key (exp_voucher);

alter table ACTUAL
add constraint FK_actual_budget foreign key (project) referencing BUDGET(project);

insert into BUDGET values(1,5100,200);
insert into BUDGET values(2,5100,50);
insert into BUDGET values(3,5100,15);
insert into BUDGET values(4,5200,66.6);
insert into BUDGET values(5,5200,33.3);
insert into BUDGET values(6,5300,75);
insert into BUDGET values(7,5300,55);
insert into BUDGET values(8,5400,160);

insert into ACTUAL values(1,1,100);
insert into ACTUAL values(2,1,15);
insert into ACTUAL values(3,1,6);
insert into ACTUAL values(4,2,43);
insert into ACTUAL values(5,4,99.9);
insert into ACTUAL values(6,8,145);
insert into ACTUAL values(7,8,83);

commit;

exit