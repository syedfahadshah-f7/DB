-- Departments Table
create user praclab06 identified by fahad;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

-- Professors Table
CREATE TABLE Professors (
    professor_id INT PRIMARY KEY,
    professor_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT NOT NULL,
    enrollment_date DATE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Courses Table (focus question)
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits IN (1,3)),
    department_id INT,
    professor_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
);

-- Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert Departments
INSERT INTO Departments VALUES (1, 'Computer Science');
INSERT INTO Departments VALUES (2, 'Electrical Engineering');
INSERT INTO Departments VALUES (3, 'Business Administration');

-- Insert Professors
INSERT INTO Professors VALUES (101, 'Dr. Ahmed Khan', 'ahmed.khan@uni.edu', 1);
INSERT INTO Professors VALUES (102, 'Dr. Fatima Ali', 'fatima.ali@uni.edu', 2);
INSERT INTO Professors VALUES (103, 'Dr. Saad Malik', 'saad.malik@uni.edu', 3);

-- Insert Students
INSERT INTO Students VALUES (201, 'Ali Raza', 'ali.raza@uni.edu', 1, to_date(('2023-09-01'),'YYYY-MM-DD'));
INSERT INTO Students VALUES (202, 'Ayesha Noor', 'ayesha.noor@uni.edu', 2, to_date(('2022-09-01'),'YYYY-MM-DD'));
INSERT INTO Students VALUES (203, 'Hassan Shah', 'hassan.shah@uni.edu', 3,to_date(( '2024-02-15'),'YYYY-MM-DD'));

-- Insert Courses
INSERT INTO Courses VALUES (301, 'Database Systems', 3, 1, 101);
INSERT INTO Courses VALUES (302, 'Digital Logic Design', 3, 2, 102);
INSERT INTO Courses VALUES (303, 'Principles of Management', 1, 3, 103);

-- Insert Enrollments
INSERT INTO Enrollments VALUES (401, 201, 301,to_date(( '2024-09-01'),'YYYY-MM-DD') , 'A');
INSERT INTO Enrollments VALUES (402, 202, 302,to_date(( '2024-09-01'),'YYYY-MM-DD') , 'B+');
INSERT INTO Enrollments VALUES (403, 203, 303,to_date(( '2024-09-01'),'YYYY-MM-DD') , 'A-');


-- Fall 2024
-- Q2
-- 2)
select s.student_name from students s join ENROLLMENTS e on
e.STUDENT_ID = s.STUDENT_ID join COURSES c on e.COURSE_ID = c.COURSE_ID
join PROFESSORS p on c.PROFESSOR_ID = p.PROFESSOR_ID where 
p.PROFESSOR_NAME like 'Dr. Ahmed Khan';

-- 3
SELECT s1.student_id AS Student1_ID,
       s1.student_name AS Student1,
       s2.student_id AS Student2_ID,
       s2.student_name AS Student2,
       s1.department_id
FROM Students s1
JOIN Students s2 
     ON s1.department_id = s2.department_id
    AND s1.student_id < s2.student_id
ORDER BY s1.department_id;


-- 4)
select s.STUDENT_NAME from students s where s.DEPARTMENT_ID = 
(select d.department_id from Departments d where d.DEPARTMENT_NAME like '%Computer Science%' ) ;
-- 5)
select d.department_name from departments d where d.DEPARTMENT_ID IN 
(select c.DEPARTMENT_ID from COURSES c group by c.DEPARTMENT_ID having count(*) >5);
-- 6)
select count(*) as Student_Count from students group by department_id order by Student_count desc;
-- 7)
delete from students s where s.STUDENT_ID IN 
(select e.student_id from Enrollments e where e.COURSE_ID = 
(select c.course_id from COURSES c where c.COURSE_NAME like '%Database Systems%'));


