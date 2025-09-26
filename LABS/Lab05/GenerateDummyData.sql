-- Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    city VARCHAR(50),
    course_id INT
);

-- Teachers Table
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(50),
    city VARCHAR(50),
    course_id INT
);

-- Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    teacher_id INT
);

-- Departments Table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Employees Table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    dept_id INT,
    manager_id INT
);


INSERT INTO Students VALUES (1, 'Ali', 'Lahore', 101);
INSERT INTO Students VALUES (2, 'Sara', 'Karachi', 102);
INSERT INTO Students VALUES (3, 'Usman', 'Lahore', 103);
INSERT INTO Students VALUES (4, 'Hina', 'Islamabad', 101);
INSERT INTO Teachers VALUES (1, 'Sir Ali', 'Lahore', 101);
INSERT INTO Teachers VALUES (2, 'Miss Sara', 'Karachi', 102);
INSERT INTO Teachers VALUES (3, 'Sir Bilal', 'Lahore', 103);
INSERT INTO Courses VALUES (101, 'Database Systems', 1);
INSERT INTO Courses VALUES (102, 'Operating Systems', 2);
INSERT INTO Courses VALUES (103, 'AI', 3);
INSERT INTO Departments VALUES (1, 'HR');
INSERT INTO Departments VALUES (2, 'IT');
INSERT INTO Departments VALUES (3, 'Finance');
INSERT INTO Employees VALUES (1, 'Ahmad', 60000, to_date('10-05-2021','MM-DD-YYYY'), 1, NULL);
INSERT INTO Employees VALUES (2, 'Bilal', 45000, to_date('03-15-2019','MM-DD-YYYY'), 1, 1);
INSERT INTO Employees VALUES (3, 'Fatima', 75000, to_date('08-20-2020','MM-DD-YYYY'), 2, 1);
INSERT INTO Employees VALUES (4, 'Khalid', 30000, to_date('11-25-2022','MM-DD-YYYY'), 2, 3);
INSERT INTO Employees VALUES (5, 'Hassan', 55000, to_date('12-07-2021','MM-DD-YYYY'), NULL, 1);
