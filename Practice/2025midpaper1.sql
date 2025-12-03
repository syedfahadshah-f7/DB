--1
select e.first_name,j.JOB_TITLE,d.DEPARTMENT_NAME,l.CITY
from employees e inner join DEPARTMENTS d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID inner join jobs j
on e.JOB_ID = j.JOB_ID inner join LOCATIONS l on 
l.location_ID = d.LOCATION_ID;

--2
select e.EMPLOYEE_ID,e.FIRST_NAME,e.salary,e.DEPARTMENT_ID from employees e where e.salary >
(select AVG(e1.salary) from employees e1 where e.DEPARTMENT_ID = e1.DEPARTMENT_ID);

-- 3
select e1.employee_id ,e1.first_name,d.DEPARTMENT_NAME from employees e1 inner join DEPARTMENTS d
on e1.DEPARTMENT_ID = d.DEPARTMENT_ID where e1.DEPARTMENT_ID = 
(select e.DEPARTMENT_ID from employees e where e.first_name like '%Steven' and e.LAST_NAME like '%King'
)  and e1.first_name NOT like '%Steven' and e1.LAST_NAME NOT like '%King';

--4
select e1.first_name,d.DEPARTMENT_NAME,e1.salary from employees e1 inner join DEPARTMENTS d
on e1.DEPARTMENT_ID = d.DEPARTMENT_ID where e1.salary = 
(select MAX(e.salary) from employees e where e1.DEPARTMENT_ID = e.DEPARTMENT_ID);

--5
select CITY,emp_count from 
(select l.CITY,count(e.EMPLOYEE_ID) as emp_count
from employees e inner join DEPARTMENTS d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID inner join LOCATIONS l on 
l.location_ID = d.LOCATION_ID group by l.city order by emp_count desc)
where rownum <=1;

--6
select m.FIRST_NAME,Count(*) as num_emp
from employees e inner join DEPARTMENTS d on 
e.DEPARTMENT_ID = d.DEPARTMENT_ID inner join employees m
on e.MANAGER_ID = m.EMPLOYEE_ID group by e.MANAGER_ID,m.FIRST_NAME;

-- 7
select e.FIRST_NAME,e.HIRE_DATE,m.first_name from employees e inner join employees m  on 
e.MANAGER_ID = m.EMPLOYEE_ID where to_date(m.HIRE_DATE) > to_date(e.HIRE_DATE);

--8

select j.job_title,AVG(e.salary) from employees e inner join jobs j on e.job_id = j.JOB_ID
group by j.job_title having AVG(e.salary) > 10000;

-- 9
select d.DEPARTMENT_ID,d.DEPARTMENT_NAME from  DEPARTMENTS d where d.DEPARTMENT_ID 
NOT IN (select DISTINCT e1.department_id from employees e1 where e1.DEPARTMENT_ID = d.DEPARTMENT_ID);

-- 10
select FIRST_NAME,SALARY,COMMISSION_PCT from 
(select e.FIRST_NAME,e.SALARY,e.COMMISSION_PCT from employees e where e.COMMISSION_PCT is not null
order by e.COMMISSION_PCT desc)where rownum <=1 ;

-- Q2

create table Customers(
    customer_id int primary key,
    first_name varchar(30) not null,
    last_name varchar(30) not null,
    email varchar(30) unique ,
    phone varchar(11) unique
);
create table Products(
    product_id int PRIMARY KEY,
    product_name varchar(20) not null,
    price int check(price > 0),
    stock_quantity int check(stock_quantity > 0)
);
create table Orders(
    order_id int primary key,
    customer_id int,
    order_date date not null,
    status varchar(20) check (status in ('Pending','Shipped','Delivered','Cancelled')),
    constraint c_fk foreign key(customer_id) REFERENCES Customers(customer_id)
);

create table OrderItems(
    order_item_id int primary key,
    order_id int,
    product_id int,
    quantity int check(quantity >= 1),
    constraint o_fk foreign key(order_id) REFERENCES Orders(order_id),
    constraint p_fk foreign key(product_id) REFERENCES Products(product_id)
);

insert into Customers values(1,'Ali','Raza','aliraza','997889');
insert into Products values(11,'Laptop',10000,10);
insert into Orders Values (21,1,to_date('19-8-2025','DD-MM-YYYY'),'Pending');
insert into ORDERITEMS values(31,21,11,2);
update Products set STOCK_QUANTITY = STOCK_QUANTITY-1
where PRODUCT_ID = 11;
update Orders set STATUS = 'Shipped' where ORDER_ID = 21;

select o.CUSTOMER_ID from OrderItems oi inner join orders o on 
oi.ORDER_ID  = o.ORDER_ID inner join products p on 
p.PRODUCT_ID = oi.PRODUCT_ID inner join CUSTOMERS c on
c.customer_id = o.CUSTOMER_ID group by o.CUSTOMER_ID having
sum(p.price) > 50000;

select product_id,order_cnt from
(select p.product_id,count(o.order_id) as order_cnt from OrderItems oi inner join orders o on 
oi.ORDER_ID  = o.ORDER_ID inner join products p on 
p.PRODUCT_ID = oi.PRODUCT_ID group by p.PRODUCT_ID 
order by order_cnt desc ) where rownum <=1;

select * from orders;


