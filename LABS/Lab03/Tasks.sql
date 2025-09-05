create user fahad IDENTIFIED BY FAHAD;

-------------- IN LAB -------------------------

-- Q1
create table employees(
    emp_id int primary key,
    emp_name varchar(5),
    salary int,
    dept_id int
);
alter table employees add constraint check_age check(salary>20000);
-- Q2

alter table employees rename column emp_name to full_name;

-- Q3
alter table employees drop constraint check_age;
insert into employees columns(emp_id,full_name,salary,dept_id) values (12,'Raghi',5000,14);

-- Q4
create table departments(
    dept_id int primary key,
    dep_name varchar(10) unique
);

insert into departments columns(dept_id,dep_name) values(14,'CY');
insert into departments columns(dept_id,dep_name) values(16,'SE');
insert into departments columns(dept_id,dep_name) values(15,'AI');

-- Q5
alter table employees add constraint foreign_key foreign key (dept_id) references departments(dept_id);

-- Q6
alter table employees add (bonus NUMBER(6,2) default 1000);

-- Q7
alter table employees add (city varchar(10) default 'Karachi',age int, check(age >18));

-- Q9
alter table employees modify (full_name varchar(20),city varchar(20));

-- Q10
alter table employees add (email varchar(20) unique);

-- Q8
--insert into EMPLOYEES columns(emp_id,full_name,salary,dept_id,email) values (3,'XYZ',40000,16,'k230003@nu.edu.pk');
--select * from employees;
delete from employees where emp_id IN(1,3);

---------------------- POST LAB --------------------

-- Q11
alter table employees add constraint unique_bonus UNIQUE(bonus);
insert into EMPLOYEES columns(emp_id,full_name,salary,dept_id,email,age,bonus) values (62,'Fahad',50000,16,'k2300062@nu.edu.pk',20,7000);
insert into EMPLOYEES columns(emp_id,full_name,salary,dept_id,email,age,bonus) values (61,'AR',40000,14,'k2300061@nu.edu.pk',21,6000);

-- Q12 
alter table employees add (dob DATE);
alter table employees add constraint check_dob check (dob <= date '2007-01-01');

-- Q13
insert into EMPLOYEES columns(emp_id,full_name,salary,dept_id,email,age,bonus,dob) values (65,'Talha',40000,15,'k2300065@nu.edu.pk',21,5000,'2008-05-08');

 
--Q14
alter table employees drop CONSTRAINT foreign_key;
insert into EMPLOYEES columns(emp_id,full_name,salary,dept_id,email,age,bonus) values (65,'Talha',40000,17,'k2300065@nu.edu.pk',21,5000);
select * from employees;
alter table employees add constraint foreign_key foreign key (dept_id) references departments(dept_id); 
-- After adding foreign key constraint error is coming "Parent key not found"

--Q15
alter table employees drop COLUMN age;
alter table employees drop COLUMN city;

-- Q16
SELECT d.dept_id, d.dep_name,e.emp_id, e.full_name FROM departments d JOIN employees e ON d.dept_id = e.dept_id;

-- Q17
alter table employees rename column salary to monthly_salary;

-- Q18
select * from departments d where d.dept_id NOT IN(SELECT dept_id FROM employees e where d.dept_id = e.dept_id);

-- Q19
delete from students;
-- Q20
select dept_id,emp_count from
(SELECT dept_id,count(*) as emp_count FROM employees group by (dept_id)order by emp_count desc)
where rownum = 1 ;
