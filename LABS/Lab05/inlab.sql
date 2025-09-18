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

-- Q1
select e.*, d.*  from EMPLOYEES e cross join DEPARTMENTS d;

-- Q2
select e.*, d.*  from EMPLOYEES e right join 
DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID ;

-- Q3
select e.employee_name,m.employee_name from employees e
inner join employees m on e.manager_id = m.employee_id;

-- Q4
select f.employee_id from employees f where f.employee_id not in 
(select e.employee_id from employees e inner join EMPLOYEE_PROJECT_ASSIGNMENT p 
on e.employee_id = p.EMPLOYEE_ID);

-- Q5
select s.student_name,c.COURSE_NAME from students s inner join ENROLLMENTS e 
on s.student_id = e.student_id inner join courses c on c.COURSE_ID = e.COURSE_ID;

-- Q6
select c.*,o.* from customers c left join orders o on
c.CUSTOMER_ID = o.CUSTOMER_ID;

-- Q7
select e.*, d.*  from EMPLOYEES e right join 
DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID ;
 
-- Q8
select t.*,s.* from teachers t cross join subjects s;
 
-- Q9
select d.department_id ,count(*) as Total_Employees 
from DEPARTMENTS d inner join  EMPLOYEES e on e.department_id = d.DEPARTMENT_ID 
group by e.department_id;

-- Q10
select s.student_name,su.subject_name,t.teacher_name from STUDENTS s
inner join ENROLLMENTS e on s.STUDENT_ID = e.STUDENT_ID inner join subjects su
on e.course_id = su.SUBJECT_ID inner join teachers t on t.TEACHER_ID = su.TEACHER_ID ;

