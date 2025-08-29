-----------------------In LAB-----------------
--1
select SUM(salary) as "TotalSalary" from EMPLOYEES;
--2
select AVG(salary) as "TotalSalary" from EMPLOYEES;
--3
select COUNT(*) as "EmployeeCount",MANAGER_ID from EMPLOYEES GROUP BY (MANAGER_ID);
--4
select * from EMPLOYEES e0 where e0.SALARY = (select MIN(SALARY) from EMPLOYEES);
--5
select * from dual;
select TO_CHAR(SYSDATE,'DD-MM-YYYY') from dual;
--6
select TO_CHAR(SYSDATE,'Day-Month-Year') from dual;
--7
select * from EMPLOYEES where to_char(HIRE_DATE,'Day') LIKE '%Wednesday%';
--8
select MONTHS_BETWEEN('01-JAN-2025','01-OCT-2024') from dual;
--9
select e.EMPLOYEE_ID,e.FIRST_NAME,TRUNC(MONTHS_BETWEEN(SYSDATE,e.HIRE_DATE)) as "Months Worked" from EMPLOYEES e;
--10
select SUBSTR(e.LAST_NAME,0,5) from EMPLOYEES e;


--------------------POST LAB --------------------------
--11
select LPAD(first_name,15,'*') from employees;
--12
select LTRIM(' ORACLE') from dual;
--13
select INITCAP(first_name) from employees;
--14
select NEXT_DAY('20-AUG-2022', 'MONDAY') from dual;
--15
select TO_CHAR(TO_DATE('25-DEC-2023'),'MM-YYYY') from dual;
--16
select DISTINCT(SALARY) from EMPLOYEES ORDER BY salary asc;
--17
select FIRST_NAME,round(salary,-2) as "Salary After Rounded" from EMPLOYEES;
--18/20
select department_id, Employee_Count from 
(select department_id, COUNT(*) as Employee_Count from EMPLOYEES GROUP BY department_id ORDER BY Employee_Count DESC) 
where ROWNUM =1; 
 
--19
select department_id, Total_salary from
(SELECT department_id, SUM(SALARY) as Total_Salary from EMPLOYEES GROUP BY department_id ORDER BY Total_Salary DESC )
where ROWNUM <=3;





