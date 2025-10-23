set serveroutput on;

declare 
sec_name varchar(20) := 'SEC-5A';
course_name varchar(20) := 'Database System Lab';

Begin
DBMS_OUTPUT.PUT_LINE(' Wecome ' || sec_name || ' to the ' || course_name );
END;
/

declare 
a int := 10;
b int := 20;
c int ;
f real ;
begin 
c := a+b;
DBMS_OUTPUT.PUT_LINE('Value of C is ' || c);
f := 70.0/3.0;
DBMS_OUTPUT.PUT_LINE('Value of f is ' || f);
end;
/

declare 
-- global variables
num1 number := 21;
num2 number := 22;

Begin 
 DBMS_OUTPUT.PUT_LINE('Outer Variable num1 ' || num1 );
 DBMS_OUTPUT.PUT_LINE('Outer Variable num2 ' || num2 );
 
declare
 -- local variable
n1 int := 45;
n2 int := 12;
BEGIN
DBMS_OUTPUT.PUT_LINE('local variable n1 and n2 are '|| n1 || ' and ' || n2 );
end;

end;
/

declare

e_name varchar(20);
begin
select first_name into e_name from employees where EMPLOYEE_ID = 101;
DBMS_OUTPUT.put_line('Employee Name is ' || e_name );
EXCEPTION
WHEN
NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('no employee found');
end;
/

declare 
begin
update employees set salary = salary*1.10 where
department_id = (select department_id from DEPARTMENTS  where department_name = 'Administration');
DBMS_OUTPUT.PUT('salary updated successfully');
end;
/

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












