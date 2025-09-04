create table STUDENTS(
    Id int primary key,
    Name VARCHAR(3),
    Email VARCHAR(20),
    Age int,
    check(age>=18)
);

select * from STUDENTS;

alter table STUDENTS add Salary int;
alter table STUDENTS add (City varchar(20) default 'Karachi', Dept_Id int);
--add single constraint
alter table STUDENTS add CONSTRAINT unique_email unique(email);
--modify multiple columns or we can modify single column
alter table STUDENTS MODIFY(Name VARCHAR(30), Email varchar(20) not null);

alter table STUDENTS add ( 
    CONSTRAINT check_age check (age between 18 and 30),
    CONSTRAINT unique_email unique(email)
);


create table DEPARTMENTS(
    Id int primary key,
    Dept_Name VARCHAR(20) not null
);

insert into DEPARTMENTS(Id,Dept_Name) values(4,'SE');

select * from DEPARTMENTS;

alter table STUDENTS drop column Dept_Id;

alter table STUDENTS add (Dept_Id int , FOREIGN key(Dept_Id) REFERENCES DEPARTMENTS(Id));
insert into STUDENTS (Id,Name,Email,Age,Salary,Dept_Id) values (65,'Talha','k230065@nu.edu.pk',20,1000,4);

delete from STUDENTS where ID IN(62,12,23,65);
