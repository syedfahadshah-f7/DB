
create user MidPractice identified by fahad;
create table Student(
    stud_id int primary key,
    stu_name varchar(100),
    stu_email varchar(100),
    stu_phone varchar(20),
    stu_dob date
);

create table Subject(
    sub_id int primary key,
    sub_name varchar(20)
);

create table Professor(
    prof_id int primary key,
    prof_name varchar(100),
    prof_email varchar(100),
    prof_phone varchar(20)
);

create table C_lass(
    class_id int primary key,
    class_code varchar(20),
    begin_date date,
    end_date date,
    sub_id int,
    prof_id int ,
    CONSTRAINT sub_fk FOREIGN KEY(sub_id) REFERENCES Subject(sub_id),
    CONSTRAINT prof_fk FOREIGN KEY(prof_id) REFERENCES Professor(prof_id)
);


create table ClassStudent(
    classstudent_id int primary key,
    stud_id int ,
    class_id int ,
    CONSTRAINT stu_fk foreign key(stud_id) REFERENCES Student(stud_id),
    CONSTRAINT class_fk foreign key(class_id) REFERENCES C_lass(class_id)
);

create table ProfessorSubject(
    profsub_id int primary key,
    sub_id int,
    prof_id int ,
    CONSTRAINT sub2_fk FOREIGN KEY(sub_id) REFERENCES Subject(sub_id),
    CONSTRAINT prof2_fk FOREIGN KEY(prof_id) REFERENCES Professor(prof_id)
);


DROP TABLE Subject CASCADE CONSTRAINTS;
DROP TABLE Professor CASCADE CONSTRAINTS;


-- Drop tables if they already exist
DROP TABLE employees CASCADE CONSTRAINTS;
DROP TABLE departments CASCADE CONSTRAINTS;
DROP TABLE jobs CASCADE CONSTRAINTS;

-- JOBS TABLE
CREATE TABLE jobs (
    job_id      VARCHAR2(10) PRIMARY KEY,
    job_title   VARCHAR2(50),
    min_salary  NUMBER(8,2),
    max_salary  NUMBER(8,2)
);

-- DEPARTMENTS TABLE
CREATE TABLE departments (
    department_id   NUMBER PRIMARY KEY,
    department_name VARCHAR2(50)
);

-- EMPLOYEES TABLE
CREATE TABLE employees (
    employee_id     NUMBER PRIMARY KEY,
    first_name      VARCHAR2(20),
    last_name       VARCHAR2(20),
    email           VARCHAR2(30),
    phone_number    VARCHAR2(20),
    hire_date       DATE,
    job_id          VARCHAR2(10) REFERENCES jobs(job_id),
    salary          NUMBER(8,2),
    commission_pct  NUMBER(3,2),
    manager_id      NUMBER,
    department_id   NUMBER REFERENCES departments(department_id)
);

-- Insert JOBS
INSERT INTO jobs VALUES ('SA_REP','Sales Representative',3000,9000);
INSERT INTO jobs VALUES ('IT_PROG','Programmer',4000,10000);
INSERT INTO jobs VALUES ('HR_REP','HR Representative',2500,6000);
INSERT INTO jobs VALUES ('FIN_MGR','Finance Manager',6000,12000);
INSERT INTO jobs VALUES ('SA_MGR','Sales Manager',8000,15000);

-- Insert DEPARTMENTS
INSERT INTO departments VALUES (10,'Sales');
INSERT INTO departments VALUES (20,'IT');
INSERT INTO departments VALUES (30,'HR');
INSERT INTO departments VALUES (40,'Finance');

-- Insert EMPLOYEES
INSERT INTO employees VALUES (101,'John','Smith','JSMITH','123456',DATE '2015-01-01','SA_REP',5000,0.20,201,10);
INSERT INTO employees VALUES (102,'Alice','Brown','ABROWN','234567',DATE '2016-03-15','SA_REP',6000,0.15,201,10);
INSERT INTO employees VALUES (103,'Michael','Lee','MLEE','345678',DATE '2014-07-10','IT_PROG',8000,NULL,202,20);
INSERT INTO employees VALUES (104,'Emma','Taylor','ETAYLOR','456789',DATE '2017-11-22','IT_PROG',7000,NULL,202,20);
INSERT INTO employees VALUES (105,'Sophia','Davis','SDAVIS','567890',DATE '2013-09-05','HR_REP',4500,NULL,203,30);
INSERT INTO employees VALUES (106,'Daniel','Wilson','DWILSON','678901',DATE '2012-04-18','FIN_MGR',10000,NULL,204,40);
INSERT INTO employees VALUES (107,'Liam','Miller','LMILLER','789012',DATE '2018-12-01','SA_REP',4000,0.25,201,10);
INSERT INTO employees VALUES (108,'Olivia','Moore','OMOORE','890123',DATE '2011-06-09','SA_MGR',12000,0.10,NULL,10);
INSERT INTO employees VALUES (109,'Noah','Taylor','NTAYLOR','901234',DATE '2010-05-17','SA_REP',5500,0.30,201,10);
INSERT INTO employees VALUES (201,'William','King','WKING','999999',DATE '2008-01-15','SA_MGR',14000,0.10,NULL,10); -- Manager
INSERT INTO employees VALUES (202,'James','White','JWHITE','888888',DATE '2009-02-20','IT_PROG',11000,NULL,NULL,20); -- Manager
INSERT INTO employees VALUES (203,'Henry','Green','HGREEN','777777',DATE '2007-03-25','HR_REP',6000,NULL,NULL,30); -- Manager
INSERT INTO employees VALUES (204,'Grace','Hall','GHALL','666666',DATE '2006-04-30','FIN_MGR',12000,NULL,NULL,40); -- Manager

------ Midterm Examination 19thOctober 2023, 1:15pm – 02:45pm

select * from jobs;
select * from EMPLOYEES;
select * from DEPARTMENTS;


--1
SELECT j.job_id, j.job_title, AVG(e.commission_pct) AS avg_commission
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE e.commission_pct IS NOT NULL
GROUP BY j.job_id, j.job_title
ORDER BY avg_commission ASC;

--2
SELECT  j.job_title, AVG(e.SALARY) AS avg_salary
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_id, j.job_title having AVG(e.SALARY) > 6000;

-- 4
select e.FIRST_NAME,e.DEPARTMENT_ID,e1.FIRST_NAME as Manager_name  from employees e 
inner join EMPLOYEES e1 on e.MANAGER_ID = e1.EMPLOYEE_ID ;

--5 
select e.FIRST_NAME,e.LAST_NAME,d.DEPARTMENT_NAME,e.salary  from employees e 
inner join DEPARTMENTS d on d.DEPARTMENT_ID = e.DEPARTMENT_ID  where e.HIRE_DATE =
(SELECT MIN(hire_date) FROM employees WHERE department_id = e.department_id);

-- 7
select e.FIRST_NAME,e.LAST_NAME,j.JOB_TITLE,e.salary  from employees e 
inner join jobs j on j.job_id = e.JOB_ID where e.salary =
(SELECT Max(salary) FROM employees WHERE job_id = e.job_id);

-- 8

select e.employee_id,e.salary from employees e where e.salary >
(select AVG(salary) from employees where DEPARTMENT_ID = e.department_id) and 
e.salary >(select AVG(salary) from employees where job_id = e.job_id) ;

-- 9 
SELECT m.first_name, m.last_name, m.email, m.salary, COUNT(e.employee_id) AS num_subordinates
FROM employees e inner join employees m on m.employee_id = e.MANAGER_ID group by m.first_name, m.last_name, m.email, m.salary
having count(e.employee_id) > 5;


