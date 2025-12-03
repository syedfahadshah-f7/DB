create table Students(
    stu_id int primary key,
    stu_name varchar(25) not null,
    h_pay int ,
    y_pay int
);
-- insert before trigger is active
insert into Students(stu_id,stu_name) values (62,'Fahad');

set serveroutput on;

create trigger before_insert
before insert on Students 
for each row
begin
    if :NEW.h_pay is NULL then
        :NEW.h_pay := 250;
        :NEW.y_pay := 250*1980;
    end if;
end;
/

-- insert after trigger is active
insert into Students(stu_id,stu_name) values (61,'Ar');
select * from Students;

create trigger before_update
before update on Students
for each row
begin
    :NEW.y_pay := :NEW.h_pay*1980;
end;
/

update Students set H_PAY = 400 where STU_ID = 62;

create trigger before_delete
before delete on Students
for each row
begin
    if :OLD.STU_NAME = 'Fahad' then
    RAISE_APPLICATION_ERROR(-20000, 'Cant Delete Admin data');
    end if;
end;
/
delete from Students where STU_ID= 62;


create table students_logs(
    stu_id int,
    stu_name varchar(20),
    inserted_by varchar(20),
    inserted_on date
);



create trigger after_insert
after insert on Students
for each row
begin
    insert into STUDENTS_LOGS values (:NEW.stu_id,:NEW.stu_name,sys_context('userenv','current_user'),sysdate );
end;
/
insert into STUDENTS values (23,'Umar',500,670000);
select * from students_logs;


CREATE table schema_audit
( 
ddl_date DATE, 
ddl_user VARCHAR2(15),
object_created VARCHAR2(15),
object_name VARCHAR2(15),
ddl_operation VARCHAR2(15)
);

create trigger ddl_trigger
after ddl on SCHEMA
declare
dbuser varchar(20);
begin
select user into dbuser from dual;
insert into SCHEMA_AUDIT values (sysdate,dbuser,ora_dict_obj_type,ora_dict_obj_name,ora_sysevent );
end;
/
insert into STUDENTS values (12,'Raghib',10,10000);
create table ddl_check(
    duser varchar(20)
);
drop trigger ddl_check;

SELECT * FROM schema_audit;
drop trigger ddl_trigger;






