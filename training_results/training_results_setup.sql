drop table TRAINING_RESULTS;

create table TRAINING_RESULTS
(training_name              varchar2(20)    not null,
 training_step              integer         not null,
 completion_date        date            -- null means incomplete
);
 
alter table TRAINING_RESULTS
add constraint PK_TRAINING_RESULTS primary key (training_name, training_step);

insert into TRAINING_RESULTS values('J2EE',1,to_date('03/02/2005','DD/MM/YYYY'));
insert into TRAINING_RESULTS values('J2EE',2,to_date('03/02/2005','DD/MM/YYYY'));
insert into TRAINING_RESULTS values('J2EE',3,to_date('03/02/2005','DD/MM/YYYY'));
insert into TRAINING_RESULTS values('J2EE',4,to_date('03/02/2005','DD/MM/YYYY'));
insert into TRAINING_RESULTS values('J2EE',5,to_date('03/02/2005','DD/MM/YYYY'));

insert into TRAINING_RESULTS values('SmallTalk',1,to_date('14/10/2012','DD/MM/YYYY'));
insert into TRAINING_RESULTS values('SmallTalk',2,to_date('11/09/2012','DD/MM/YYYY'));
insert into TRAINING_RESULTS values('SmallTalk',3,to_date('01/11/2012','DD/MM/YYYY'));

insert into TRAINING_RESULTS values('C',1,to_date('31/08/1988','DD/MM/YYYY'));
insert into TRAINING_RESULTS values('C',2,null);
insert into TRAINING_RESULTS values('C',3,to_date('03/09/1988','DD/MM/YYYY'));

insert into TRAINING_RESULTS values('Groovy',1,to_date('25/04/2015','DD/MM/YYYY'));
insert into TRAINING_RESULTS values('Groovy',2,to_date('08/07/2015','DD/MM/YYYY'));
insert into TRAINING_RESULTS values('Groovy',3,to_date('22/08/2015','DD/MM/YYYY'));
insert into TRAINING_RESULTS values('Groovy',4,null);

commit;

exit