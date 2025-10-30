create user Lab09 identified by fahad;


create table Students(
    stu_id int primary key,
    stu_name varchar(25) not null,
    h_pay int ,
    y_pay int
);
-- insert before trigger is active
insert into Students(stu_id,stu_name) values (62,'Fahad');

set serveroutput on;

-- DML Triggers
-- Before Insert

-- Mubarak ho pahla trigger 
create or replace trigger insert_data
before insert on Students
for each row
begin

IF :NEW.h_pay is null then
:NEW.h_pay := 250;
end if;

end;
/


-- insert after trigger is active
insert into Students(stu_id,stu_name) values (23,'Umar');
insert into Students(stu_id,stu_name) values (12,'raghib');


-- before Update
create or replace trigger update_salary
before update on Students
for each row
begin

:NEW.y_pay := :NEW.h_pay*1920;

end;
/

update Students set H_PAY = 300 where stu_id = 23;
select * from Students;

-- before Delete
create or replace trigger prevent_admin
before delete on Students
for each row
begin

IF :OLD.stu_name = 'Fahad' -- admin = fahad
then
RAISE_APPLICATION_ERROR(-20000,'You can not delete admin/ Fahad record');
end if;
end;
/

delete from Students where stu_name = 'Fahad';

create table students_logs(
    stu_id int,
    stu_name varchar(20),
    inserted_by varchar(20),
    inserted_on date
);

-- After Insert 

create or replace trigger after_insert
after insert on Students
for each row
begin

insert into students_logs(stu_id,stu_name,inserted_by,inserted_on) values 
(:NEW.stu_id,:NEW.stu_name,SYS_CONTEXT('USERENV','SESSION_USER'),SYSDATE);
end;
/
insert into Students(stu_id,stu_name) values (65,'Talha');
select * from STUDENTS_LOGS;


-- After Delete
-- Activity Q1
create table students_delete_logs(
    stu_id int,
    stu_name varchar(20),
    deleted_by varchar(20),
    deleted_on date
);


create or replace trigger after_delete
after delete on Students
for each row
begin
insert into students_delete_logs(stu_id,stu_name,deleted_by,deleted_on) values 
(:OLD.stu_id,:OLD.stu_name,SYS_CONTEXT('USERENV','SESSION_USER'),SYSDATE);
end;
/

delete from students where stu_id = 23;
select * from STUDENTS_DELETE_LOGS;


-- DDL Triggers

create or replace trigger prevent_tables
before drop on DATABASE
begin 
RAISE_APPLICATION_ERROR(num => -20000, msg => 'Cannot Drop Object');
end;
/
DROP TABLE students_logs;

-- Activity 2

create or replace trigger prevent_students_table
before drop on schema
begin 
IF  ora_dict_obj_name = 'STUDENTS' and ora_dict_obj_type = 'TABLE'
then
RAISE_APPLICATION_ERROR(num => -20000, msg => 'Cannot Drop Object');
end if;
end;
/

DROP TABLE students;

--  maintain whole history of DDL operations

