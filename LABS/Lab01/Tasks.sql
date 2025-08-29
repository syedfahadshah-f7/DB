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

-----------------      POST LAB TASKS           ------------------

--Q:11 
select * from EMPLOYEES where HIRE_DATE BETWEEN '1-JAN-05' AND '31-DEC-06'

--Q:12 
select * from EMPLOYEES where MANAGER_ID IS NULL;
 
--Q:13 
select * from EMPLOYEES where SALARY < ALL (select SALARY from EMPLOYEES where SALARY > 8000);

--Q:14 
select * from EMPLOYEES where SALARY > ANY (select SALARY from EMPLOYEES where DEPARTMENT_ID = 90);

--Q:15 
select * from DEPARTMENTS d where EXISTS(select * from EMPLOYEES e where e.DEPARTMENT_ID = d.DEPARTMENT_ID);

--Q:16 
select * from DEPARTMENTS d where NOT EXISTS(select * from EMPLOYEES e where e.DEPARTMENT_ID = d.DEPARTMENT_ID);

--Q:17 
select * from EMPLOYEES where SALARY NOT BETWEEN 5000 AND 15000;

--Q:18 
select * from EMPLOYEES where DEPARTMENT_ID IN(10,20,30) AND DEPARTMENT_ID != 40;

--Q:19 
select * from EMPLOYEES where SALARY < ALL (select SALARY from EMPLOYEES where DEPARTMENT_ID = 50);

--Q:20 
select * from EMPLOYEES where SALARY > ALL (select SALARY from EMPLOYEES where DEPARTMENT_ID = 90);
