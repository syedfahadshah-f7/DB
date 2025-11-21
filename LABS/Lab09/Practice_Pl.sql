-- Write on top of every PL SQL working File 
set SERVEROUTPUT ON;

-- Variable Declaration
Declare
-- Declare Varibales here 
std_name varchar(20) := 'Fahad';
std_id int := 62;
Begin
-- perform all operations here
dbms_output.put_line('Student Name: ' || std_name || 'Student Roll NO: ' || std_id);
End;
/

declare 
-- global variables
num1 number := 21;
num2 number := 22;

Begin 
declare
 -- local variable
num1 int := 45;
num2 int := 12;
BEGIN
DBMS_OUTPUT.PUT_LINE('local variable num1 and num2 are '|| num1 || ' and ' || num2 );
end;
 DBMS_OUTPUT.PUT_LINE('Outer Variable num1 ' || num1 );
 DBMS_OUTPUT.PUT_LINE('Outer Variable num2 ' || num2 );
end;
/

-- variable data type and value instantiation through tables
declare

e_id EMPLOYEES.EMPLOYEE_ID%TYPE;
e_name EMPLOYEES.first_name%TYPE;
d_name departments.department_name%TYPE;

begin
select employee_id, first_name, department_name into e_id, e_name, d_name from
employees  inner join DEPARTMENTS on  employees.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID where EMPLOYEE_ID = 100;
DBMS_OUTPUT.put_line('Employee Id: '|| e_id);
DBMS_OUTPUT.put_line('Employee First Name: '|| e_name);
DBMS_OUTPUT.put_line('Department Name : '|| d_name);

end;
/

-- Conditional Statments

declare
e_sal EMPLOYEES.EMPLOYEE_ID%type;
begin 
select e.salary into e_sal from employees e where e.employee_id = 100;
if(e_sal > 30000)
then
dbms_output.put_line('If true');
elsif (e_sal >20000)
then
dbms_output.put_line('Else if true');
else
dbms_output.put_line('Else true');
end if ;
end;
/


-- Switch Case

declare

e_id EMPLOYEES.EMPLOYEE_ID%TYPE := 100; 
e_sal EMPLOYEES.salary%TYPE;
e_did EMPLOYEES.department_id%TYPE;

begin
select salary, department_id into e_sal, e_did from employees  where EMPLOYEE_ID = e_id;

case e_did 
when 90 then 
update employees set SALARY = e_sal+100 where employee_id = e_id;
DBMS_OUTPUT.PUT_LINE('Salary Updated: ' || e_sal);

when 50 then 
update employees set SALARY = e_sal+200 where employee_id = e_id;
DBMS_OUTPUT.PUT_LINE('Salary Updated: ' || e_sal);

when 40 then 
update employees set SALARY = e_sal+300 where employee_id = e_id;
DBMS_OUTPUT.PUT_LINE('Salary Updated: ' || e_sal);

ELSE
DBMS_OUTPUT.PUT_LINE('No Such Record');

END CASE;
end;
/


-- Loops 

declare 
e_f EMPLOYEES.FIRST_NAME%type;
e_l EMPLOYEES.FIRST_NAME%type;
e_sal EMPLOYEES.salary%type;

begin 
for c in (select first_name, last_name,salary from employees)
loop
e_f := c.first_name;
e_l := c.last_name;
e_sal := c.salary;
dbms_output.put_line('Fist Name: '|| c.first_name || 'Last Name: '||c.last_name || 'Salary: ' ||c.salary );
end loop;
end;
/

-- views

-- updatable view
create or replace view emp_info as
select e.first_name , e.last_name , d.department_name
from employees e inner join departments d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;
/

-- readable only view
create view emp_onlyread_info as
select e.first_name , e.last_name , d.department_name
from employees e inner join departments d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
WITH READ ONLY;
/
--drop view emp_onlyread_info;
update emp_onlyread_info set FIRST_NAME = 'Jennifer' where FIRST_NAME like 'Fahad'; 
select *from emp_info;

-- Materealized View
-- Give Permission to Hr DB to store tables in DB
Grant create  materialized view to hr;
create MATERIALIZED view  dept_info
-- refresh fast on commit as
refresh complete on demand as
select d.department_id, d.department_name, l.city
from departments d inner join locations l on d.location_id = l.LOCATION_ID;
/

select * from dept_info;

-- procedure 
-- with out parameters

create or replace procedure print_emp 
as 
begin
for c in (SELECT * from employees)
loop 
dbms_output.put_line( 'First Name: '|| c.first_name || ' Last Name: ' ||
c.last_name || ' Salary: ' || c.salary);
end loop;
end;
/

exec print_emp;

-- with parameters

create or replace procedure insert_data(e_id int , e_fn varchar, e_ln varchar)
as
e_exist int ;
begin
select count(*) into e_exist from employees e where e.employee_id = e_id;
if (e_exist = 0)
then
insert into employees (employee_id, first_name, last_name)
values (e_id,e_fn,e_ln);
else
dbms_output.put_line('employee already exist');
end if;
end;
/
--drop procedure insert_data;
begin
 insert_data(e_id => 62, e_fn => 'fahad', e_ln => 'Shah' );
end;
/

-- Cursor

Declare
cursor emp is select first_name,last_name from employees;
e_fn employees.first_name%type;
e_ln employees.last_name%type;
begin 

open emp;
loop
fetch emp into e_fn,e_ln;
exit when emp%notfound;
dbms_output.put_line('First Name: ' || e_fn || ' Last Name: ' || e_ln);
end loop;
close emp;

end;
/

-- function

create or replace function calculate_salary(dept_id int)
return number is
total_salary int := 0;
Begin
select SUM(salary) into total_salary from employees  where DEPARTMENT_ID = dept_id;
return total_salary;
End;
/

select calculate_salary(90) from dual;





