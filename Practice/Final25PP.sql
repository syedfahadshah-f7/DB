set transaction name 'Mediacal_Store_Concurrency';
create table customers(
    cust_id int primary key,
    name varchar(50)
);

create table medicines(
    med_id int primary key,
    name varchar(50),
    stock int ,
    price INT
);

create table orders(
    order_id int primary key,
    cust_id int ,
    constraint fk1 foreign key(cust_id) REFERENCES customers(cust_id)
);

create table order_item(
    item_id int primary key,
    order_id int,
    med_id int ,
    qty int,
    constraint fk2 foreign key(order_id) REFERENCES orders,
    constraint fk3 foreign key(med_id) REFERENCES medicines
);

create table order_log(
    log_id int primary key,
    order_id int ,
    message varchar(40)
);
alter table order_log add constraint fk4 foreign key(order_id) REFERENCES orders(order_id);
savepoint sp1;

set serveroutput on;


insert into CUSTOMERS values (62,'fahad');
insert into medicines values (1,'brufen',5,50);
savepoint sp2;

insert into orders values (30,62);
insert into ORDER_ITEM values (1,30,1,7);

-- updating stock
update MEDICINES set STOCK = STOCK - 7  where med_id = 1;
select * from medicines;


DECLARE
    med_exc EXCEPTION;
    med_st INT;
BEGIN

    SELECT stock  INTO med_st FROM MEDICINES WHERE MED_ID = 1;

    IF med_st < 0 THEN
        RAISE med_exc;
    END IF;

    INSERT INTO ORDER_LOG  VALUES (1, 30, 'Transaction Successfull');
    COMMIT;

EXCEPTION
    WHEN med_exc THEN
        INSERT INTO ORDER_LOG VALUES (2,30,'Insufficient Stock');
        ROLLBACK TO SAVEPOINT sp2;
        DBMS_OUTPUT.PUT_LINE('Insufficient Stock');

    WHEN OTHERS THEN
        
        INSERT INTO ORDER_LOG VALUES (3,30,'Transaction Failed');
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transaction Failed');
END;
/



select * from orders;
select * from medicines;
--drop table order_log;
--drop table order_item;
--drop table orders;
--drop table customers;
--drop table medicines;


--- Q2 a
create table Product(
    product_id int primary key,
    product_name varchar(30),
    price int ,
    stock_qty int,
    subtotal int ,
    updated_by varchar(30),
    created_by varchar(30),
    last_updated date
);

create trigger prevent_negative_values 
before insert or UPDATE on Product
for each row
declare
dbuser varchar(30);
begin
select user into dbuser from dual;
-- 1)
if :NEW.price <= 0 or :NEW.stock_qty <=0 then
RAISE_APPLICATION_ERROR(-20000, 'Product price or product quantity can not be zero');
end if;
-- 3)
if UPDATING and :OLD.stock_qty /2 < :NEW.stock_qty  then
RAISE_APPLICATION_ERROR(-20000, 'Stock Reduction Exceed allowed limit(50%)');
end if;
-- 5)
if INSERTING then
    :NEW.created_by := dbuser;
end if;
if UPDATING then
    :NEW.updated_by := dbuser;
end if;
-- 6)
:NEW.last_updated := sysdate;

-- 2)

for p in (select stock_qty,product_name from Product)
loop 
if p.stock_qty < 5 then 
DBMS_OUTPUT.PUT_LINE('The '|| p.product_name || ' is going out of stock' );
end if;
end loop;

-- 4
if :NEW.subtotal is not null then
RAISE_APPLICATION_ERROR(-20000, 'The Field can not be updated Manually');
else 
:NEW.subtotal := :NEW.price * :NEW.stock_qty;
end if;

end;
/
insert into Product (product_id,product_name,price,stock_qty) values 
(1,'ABC',4,9);
insert into Product (product_id,product_name,price,stock_qty,subtotal) values 
(1,'DEF',6,5,78);

update Product set stock_qty = stock_qty - 6 where product_id = 1;

--drop trigger prevent_negative_values;


select * from Product;

-- Q3

create type order_item as object(
    i_name varchar(50),
    qty int,
    price int,
    member function total_cost return int
)
/
create type body order_item as 
member FUNCTION total_cost return int is
cost int;
dis int;
begin
    cost := qty*price;
    if qty > 5 then 
    dis  := (cost/100)*5;
    cost := cost - dis;
    end if;
    return cost;
end;
end;
/

create table object_table of order_item;

insert into object_table values (order_item('eggs',6,10));
insert into object_table values (order_item('jelly',4,100));
insert into object_table values (order_item('shoes',8,20));

select * from OBJECT_TABLE;

select o.*,o.total_cost() as "BILL Amount" from OBJECT_TABLE o;

select max(o.total_cost()) as "MAX BILL Amount" from OBJECT_TABLE o;

--- Q1
-- 1
select * from employees;
select * from jobs;
select * from departments;

select d.DEPARTMENT_NAME,count(e.EMPLOYEE_ID) as "emp_cnt" from DEPARTMENTS d inner join employees e on d.DEPARTMENT_ID =
 e.department_id  where e.salary > 5000 group by e.department_id,d.DEPARTMENT_NAME having count(e.EMPLOYEE_ID) >3;

select * from employees e where e.salary > (select AVG(e1.salary) from employees e1 where to_char(e1.hire_date,'Year') like  to_char(e.hire_date,'Year'));














