set serveroutput on;

Declare
emp_id Employees.employee_id%type := 101;
emp_fn varchar(30);
emp_ln varchar(30);
Begin
select first_name ,last_name into emp_fn,emp_ln from Employees where EMPLOYEE_ID = emp_id;
DBMS_OUTPUT.PUT_LINE('EMP ID: ' || emp_id || ' First Name: ' || emp_fn || ' Last Name: ' || emp_ln);
End;
/

Declare
emp_id Employees.employee_id%type := 101;
emp_s Employees.salary%type ;
emp_ln varchar(30);
Begin
select salary into emp_s from Employees where EMPLOYEE_ID = emp_id;
if emp_s < 20000 then 
update employees set salary = salary+ 5000 where EMPLOYEE_ID = emp_id;
elsif emp_s <10000 then
update employees set salary = salary + 1000 where EMPLOYEE_ID = emp_id;
else
update employees set salary = salary + 15000 where EMPLOYEE_ID = emp_id;
end if;
End;
/

declare 
emp_id int := 101;
emp_d EMPLOYEES.DEPARTMENT_ID%type;
begin
select department_id into emp_d from employees where employee_id = emp_id;
case emp_d
when 100 then
DBMS_OUTPUT.PUT_LINE('IN case 1');
when 90 then
DBMS_OUTPUT.PUT_LINE('IN case 2');
else
DBMS_OUTPUT.PUT_LINE('IN Else Case');
end case;
end;
/

declare
begin
for c in (select * from employees e inner join departments d on e.department_id = d.department_id  )
loop
DBMS_OUTPUT.PUT_LINE (c.first_name || ' ' || c.department_name);
end loop;
end;
/

select * from employees;
-- updatable view
create or replace view emp_details as
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,DEPARTMENT_ID from employees;
/
select * from emp_details;
update EMP_DETAILS set FIRST_NAME = 'Fahad' , LAST_NAME = 'Shah' where
EMPLOYEE_ID = 100;

-- readable view
create view emp_dep_details as 
select e.EMPLOYEE_ID,e.FIRST_NAME,d.DEPARTMENT_NAME  from EMPLOYEES e inner join 
DEPARTMENTS d on e.department_id = d.DEPARTMENT_ID
with read only;
select * from EMP_DEP_DETAILS;
/

-- materialized view
--grant create materialized view to hr;

create MATERIALIZED view dept_info 
refresh complete on demand as
select d.DEPARTMENT_NAME,l.CITY from departments d inner join 
locations l on d.location_id =l.location_id;
/


exec dbms_mview.refresh('dept_info','complete');


--------------------------------------------------------------
CREATE TABLE customers(
    cust_id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    city VARCHAR2(50)
);

INSERT INTO customers VALUES (1, 'Fahad', 'Lahore');
INSERT INTO customers VALUES (2, 'Ayesha', 'Karachi');
INSERT INTO customers VALUES (3, 'Ali', 'Islamabad');
INSERT INTO customers VALUES (4, 'Sara', 'Lahore');
INSERT INTO customers VALUES (5, 'Hamza', 'Karachi');

CREATE TABLE orders(
    order_id NUMBER PRIMARY KEY,
    cust_id NUMBER,
    amount NUMBER,
    order_date DATE,
    FOREIGN KEY(cust_id) REFERENCES customers(cust_id)
);
INSERT INTO orders VALUES (101, 1, 5000, DATE '2025-01-10');
INSERT INTO orders VALUES (102, 2, 12000, DATE '2025-01-12');
INSERT INTO orders VALUES (103, 1, 3000, DATE '2025-01-15');
INSERT INTO orders VALUES (104, 3, 7000, DATE '2025-01-20');
INSERT INTO orders VALUES (105, 4, 2000, DATE '2025-01-25');
INSERT INTO orders VALUES (106, 2, 25000, DATE '2025-02-01');

CREATE TABLE products(
    product_id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    price NUMBER
);
INSERT INTO products VALUES(1, 'Mobile', 20000);
INSERT INTO products VALUES(2, 'Laptop', 80000);
INSERT INTO products VALUES(3, 'Keyboard', 1500);
INSERT INTO products VALUES(4, 'Mouse', 800);
INSERT INTO products VALUES(5, 'Tablet', 30000);

CREATE TABLE order_items(
    item_id NUMBER PRIMARY KEY,
    order_id NUMBER,
    product_id NUMBER,
    quantity NUMBER,
    FOREIGN KEY(order_id) REFERENCES orders(order_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id)
);
INSERT INTO order_items VALUES (1, 101, 1, 1);
INSERT INTO order_items VALUES (2, 102, 2, 1);
INSERT INTO order_items VALUES (3, 103, 3, 2);
INSERT INTO order_items VALUES (4, 104, 4, 3);
INSERT INTO order_items VALUES (5, 105, 5, 1);
INSERT INTO order_items VALUES (6, 106, 1, 2);

create function total_amnt_spent(cid INT)
return INT is 
total_amount int;
begin
select sum(amount) into total_amount  from ORDERS where cust_id = cid;
return total_amount;
end;
/

create function get_price (pid INT)
return int is 
price int;
begin
select price into price from PRODUCTS where PRODUCT_ID = pid;
return price;
end;
/

create function get_total_qty(oid int)
return int is
sum_qty int;
begin
select sum(quantity) into sum_qty from ORDER_ITEMS where ORDER_ID = oid;
return sum_qty;
end;
/

create procedure add_cust(cid int,n varchar,city varchar )is
begin
insert into customers values (cid,n,city);
end;
/


CREATE OR REPLACE PROCEDURE print_cust(
    p_name VARCHAR2,
    p_city VARCHAR2
)
IS
BEGIN
    FOR rec IN (
        SELECT o.order_id,o.amount, o.order_date, c.cust_id
        FROM customers c JOIN orders o ON c.cust_id = o.cust_id
        WHERE c.name = p_name AND c.city = p_city)
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'CID: ' || rec.cust_id ||
            ' | Order ID: ' || rec.order_id ||
            ' | Amount: ' || rec.amount ||
            ' | Date: ' || rec.order_date
        );
    END LOOP;
END;
/

declare
cursor ord is select * from orders where amount > 5000;
oid int;
cid int;
amount int;
od date;
begin
open ord;
loop
fetch ord into oid,cid,amount,od;
exit when ord%notfound;
DBMS_OUTPUT.PUT_LINE('Orded Id: ' || oid || ' CID: '|| cid || ' Amount: ' || amount || ' Order Date: ' || od );
end loop;
close ord;
end;
/

declare
cursor cus is select cust_id,name from customers where city like 'Lahore';
cid int;
name varchar(40);
begin
open cus;
loop
fetch cus into cid,name;
exit when cus%notfound;
DBMS_OUTPUT.PUT_LINE(' CID: '|| cid || ' Name: ' || name );
end loop;
close cus;
end;
/


begin
add_cust(7,'Hassan','Karachi');
end;
/

begin
print_cust('Fahad','Lahore');
end;
/

select total_amnt_spent(1) from dual;
select get_price(3) from dual;
select get_total_qty(103) from dual;


select * from customers;
select * from orders;
select * from products;
select * from order_items;

--- Custome Object Type
create type cordinates as object (
    x1 int,
    y1 int,
    x2 int,
    y2 int,
    member function dist return int -- function prototype
)
/
create type body cordinates as -- function body
member function dist return int is
begin
return ((x2-x1)+(y2-y1));
end;
end;
/
-- table with the  custome data type
create table plane of cordinates;
-- insertion in table
insert into plane values(cordinates(5,6,7,8));
select * from plane;


