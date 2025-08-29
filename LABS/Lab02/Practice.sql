select COUNT(*) as total_emp from EMPLOYEES;
select COUNT(*) as total_emp , DEPARTMENT_ID from EMPLOYEES group by (DEPARTMENT_ID);
select DISTINCT manager_id from EMPLOYEES;
select manager_id from EMPLOYEES GROUP BY MANAGER_ID;
select SUM(salary) as Total_Salary from EMPLOYEES;
select MIN(salary) as Total_Salary from EMPLOYEES;
select MAX(salary) as Total_Salary from EMPLOYEES;
select SUM(salary) as Total_Salary,DEPARTMENT_ID from EMPLOYEES group by (MANAGER_ID);
select *from EMPLOYEES e0 where e0.salary = ALL(select MAX(salary) from EMPLOYEES);
select first_name||' ' ||salary as first_name_and_salary from EMPLOYEES;
select salary from EMPLOYEES order by (salary) asc;
select FIRST_NAME,HIRE_DATE from EMPLOYEES order by (FIRST_NAME) desc;
select * from EMPLOYEES e0 where e0.FIRST_NAME like 'Al%';
select * from EMPLOYEES e0 where e0.FIRST_NAME like '___a%';

--numeric function
select * from DUAL;
select abs(-90.5) from dual;
select ceil(-90.5) from dual;
select ceil(90.5) from dual;
select floor(67.5) from dual;
select trunc(852.79,-2) from dual;
select round(52.79,1) from dual;
select least(90,89,67) from dual;
select greatest(90,89,67) from dual;

--string function
select lower('FAHAD') from dual;
select first_name, lower(first_name) from employees;
select first_name, upper(first_name) from employees;
select INITCAP('FAHAD') from dual;
select INITCAP(first_name), length(first_name) from employees;
select ltrim('   Fahad')from dual;
select rtrim('Fahad    ')from dual;
select substr('Syed Fahad Faheem Shah',6,5) from dual;
select lpad('Fahad ',12,'*' ) from dual;
select rpad('Raghib ',12,'*A*N' ) from dual;

-- date funtion 
select add_months('16-sep-1900',2) from dual;
select MONTHS_BETWEEN('02-dec-1995','02-sep-1995') from dual;
select next_day('28-aug-2025','Monday') from dual;

--conversion function 
select TO_CHAR(sysdate, 'DD-MM-YY') from dual;

--select employee_id from EMPLOYEES e0 where '%SATURDAY%' =ANY(select TO_CHAR(e0.hire_date , 'DAY') from employees);
select * from employees where TO_CHAR(hire_date , 'DAY') LIKE '%SATURDAY%';
