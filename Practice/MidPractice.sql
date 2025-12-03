-- Lab1
select * from employees where DEPARTMENT_ID != 100;
select * from employees e where e.SALARY IN(10000,12000,15000);
select e.first_name , e.salary from employees e where e.salary <= 25000;
select * from employees where DEPARTMENT_ID != 60;
select * from employees where DEPARTMENT_ID BETWEEN 60 and 80;
select * from employees e where e.first_name like '%Steven%';
select * from employees where salary BETWEEN 15000 and 25000 and DEPARTMENT_ID = 80;
select e.* from employees e where e.salary < 
ANY(select salary from EMPLOYEES where department_id = 100);
select e.* from employees e where e.EMPLOYEE_ID = 
ALL(select e1.EMPLOYEE_ID from EMPLOYEES e1 where e.DEPARTMENT_ID = e1.DEPARTMENT_ID);

select * from employees where HIRE_DATE BETWEEN '01-JAN-05' and '31-DEC-06';
select * from employees e where e.MANAGER_ID is NULL;
select e.* from employees e where e.salary < 
ALL(select salary from EMPLOYEES where salary > 8000);
select e.* from employees e where e.salary > 
ANY(select salary from EMPLOYEES where department_id = 90);
select d.department_id from DEPARTMENTS d where EXISTS
(select e.DEPARTMENT_ID from employees e where e.DEPARTMENT_ID = d.DEPARTMENT_ID );
select d.department_id from DEPARTMENTS d where NOT EXISTS
(select e.DEPARTMENT_ID from employees e where e.DEPARTMENT_ID = d.DEPARTMENT_ID );

select * from employees where salary NOT BETWEEN 5000 and 15000 ;
select * from employees e where e.DEPARTMENT_ID = 10 or e.DEPARTMENT_ID = 20
or e.DEPARTMENT_ID=30 and e.DEPARTMENT_ID !=40;
select e.* from employees e where e.salary < 
ALL(select salary from EMPLOYEES where department_id = 50);
select e.* from employees e where e.salary > 
ALL(select salary from EMPLOYEES where department_id = 90);

---- Lab 4
select * from department;
select * from student;
select * from course;
select * from faculty;
select * from facultycourse;
select * from ENROLLMENT;

select DEPT_ID,count(*) as Number_Of_studnet from student group by DEPT_ID;

select d.dept_id , d.dept_name from DEPARTMENT d where d.dept_id IN 
(select s.dept_id from student s group by s.DEPT_ID having AVG(s.GPA) > 3.0);

select AVG(s.fee_paid) from student s inner join ENROLLMENT e on 
e.student_id = s.STUDENT_ID group by e.COURSE_ID;

select count(*) from faculty group by dept_id;

select f.faculty_name from faculty f where f.salary > 
(select AVG(salary) from FACULTY );

select s.STUDENT_ID from student s where s.gpa > ANY
(select GPA from student where DEPT_ID = 1);

select student_id,GPA from
(select student_id,GPA from student order by GPA desc)
where rownum <=3;

select dept_id,SUM(fee_paid) from student group by dept_id;

select distinct c.course_name from course c, ENROLLMENT e , student s where 
s.student_id = e.STUDENT_ID and c.COURSE_ID = e.COURSE_ID and s.gpa > 3.5;

select dept_id,SUM(fee_paid) from student group by dept_id having SUM(fee_paid) > 100000;

select did from 
(select f.faculty_id  as fid,f.DEPT_ID as did from FACULTY f where f.salary > 100000)
group by did having count(fid) > 1;

delete from student s where s.GPA < (select AVG(GPA) from student);

delete from course where COURSE_ID NOT IN 
(select distinct e.course_id from ENROLLMENT e );

insert into HighFee_Students select * from student where fee_paid >
(select AVG(s.fee_paid) from student s);

select dept_id,MAX_FEE from 
(select s.dept_id , SUM(s.fee_paid) as MAX_FEE from student s group by s.DEPT_ID 
order by MAX_FEE desc) where rownum <= 1;

select e.student_id from student s , ENROLLMENT e where e.STUDENT_ID = s.STUDENT_ID 
and s.gpa >(select AVG(GPA) from student)
group by e.student_id having COUNT(*) > 3 ;

insert into Unassigned_faculty select * from faculty where faculty_id 
not in (select distinct fc.faculty_id from facultycourse fc );

---- Lab 5

select * from EMPLOYEE_PROJECT_ASSIGNMENT;
select * from departments;
select * from employees;
select * from students;
select * from ENROLLMENTS;
select * from COURSES;
select * from teachers;
select * from customers;
select * from orders;
select * from subjects;


select * from employees e CROSS JOIN DEPARTMENTS d ;

select * from employees e right join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

select * from employees e inner join EMPLOYEES m on e.MANAGER_ID = m.EMPLOYEE_ID;

select f.employee_id from employees f where f.employee_id not in 
(select e.employee_id from  EMPLOYEE_PROJECT_ASSIGNMENT e );

select * from CUSTOMERS c left join orders o
on c.CUSTOMER_ID = o.customer_id ;

select * from teachers t cross join subjects s;

