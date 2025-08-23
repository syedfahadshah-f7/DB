-----------------      IN LAB TASKS           ------------------
--Q:1 
select * from EMPLOYEES where DEPARTMENT_ID != 100;

--Q:2
select * from EMPLOYEES where SALARY IN(10000,12000,15000);

--Q:3 
select FIRST_NAME,SALARY from EMPLOYEES where SALARY <= 25000;

--Q:4 
select * from EMPLOYEES where DEPARTMENT_ID <> 60;

--Q:5 
select * from EMPLOYEES where DEPARTMENT_ID BETWEEN 60 AND 80;

--Q:6 
select * from DEPARTMENTS

--Q:7 
select * from EMPLOYEES where FIRST_NAME = 'Steven';

--Q:8 
select * from EMPLOYEES where SALARY BETWEEN 15000 AND 25000 AND DEPARTMENT_ID = 80;

--Q:9 
select * from EMPLOYEES where SALARY < ANY(select SALARY from EMPLOYEES where DEPARTMENT_ID = 100);

--Q:10 
select * from EMPLOYEES emp0 where NOT EXISTS( select * from EMPLOYEES emp1 where emp0.EMPLOYEE_ID <> emp0.EMPLOYEE_ID and emp1.DEPARTMENT_ID = emp0.DEPARTMENT_ID);
