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
