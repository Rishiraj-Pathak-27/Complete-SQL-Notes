## Revisiting complete basics of the SQL

# 1. Creating databases
CREATE DATABASE IF NOT EXISTS startersql;
USE startersql;

# 2. drop database
DROP DATABASE IF EXISTS startersql;

#3. create table

CREATE TABLE student(
id INT PRIMARY KEY,
name VARCHAR(100),
age int NOT NULL,
email VARCHAR(30) UNIQUE NOT NULL,
gender ENUM("male","female","other"),
grade VARCHAR(1),
dob DATE
);

# 4. used to display data from the table
SELECT * FROM student;
SELECT name, gender FROM student;

#5. drop tables
DROP TABLE IF EXISTS student;

#6. Renaming the table
RENAME TABLE student TO customers; 
RENAME TABLE customers TO student;

#6. Constraints in SQL
#a) NOT NULL
#b) UNIQUE
#c) PRIMARY KEY
#d) FOREIGN KEY
#e) DEFAULT
#f) CHECK

CREATE TABLE customer(
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
rollno INT UNIQUE,
age INT NOT NULL CHECK (age >= 18)
);

SELECT * FROM customer;

CREATE TABLE product(
id INT PRIMARY KEY,
prod_name VARCHAR(50) NOT NULL,
cust_id INT,
price DECIMAL(10,2) DEFAULT 0.00,
FOREIGN KEY (cust_id) REFERENCES customer(id)
);

SELECT * FROM product;

#7. Inserting values in Table

INSERT INTO student
VALUES
(101,"Rishiraj",20,"rishirajraj124@gmail.com","male",'A',"2005-12-27"),
(102,"Alice",32,"alice@gmail.com","male","C","1995-10-12"),
(103,"Julie",21,"julie@gmail.com","female",'A',"2004-12-22"),
(104,"John",18,"john@gmail.com","male",'C',"2007-03-01");

SELECT * FROM student;

#8. Updating Values in table

UPDATE users
SET salary = 50000
WHERE id = 2;

SET SQL_SAFE_UPDATES = 0;

UPDATE users
SET salary = salary + 10000
WHERE salary<50000;

UPDATE users
SET name = "Arav"
WHERE id = 1;

SELECT * FROM users;

#9. Deleting values from Users

DELETE FROM users
WHERE id=24 AND 25;

#10. Functions in SQL
#a) COUNT()
#b) MAX()
#c) MIN()
#d) sum()
#e) AVG()
################
## STRING FUNCTIONS
#f) LENGTH()
#g) LOWER()
#h) UPPER()

SELECT COUNT(*) FROM users WHERE gender = "female";
SELECT MAX(salary) AS Max_salary, MIN(salary) AS Min_salary FROM users;
SELECT SUM(salary) AS total_salary FROM users;
SELECT AVG(salary) AS avg_salary FROM users;
SELECT gender, SUM(salary) AS avg_salary FROM users GROUP BY gender;
SELECT id, gender,name,LENGTH(name) AS name_len FROM users;
SELECT id, gender,UPPER(name),LOWER(name),CONCAT(LOWER(name), "2005") AS username,NOW() as time, YEAR(NOW()) AS year,DAY(NOW()) AS day,LENGTH(name) AS name_len FROM users;
SELECT NOW();
SELECT NOW() as time_now,YEAR(NOW()) AS year,DAY(NOW()) AS day,MONTH(NOW()) AS month;

# 11) Commit & Rollback
DELETE FROM users WHERE id=6;
ROLLBACK;
SELECT * FROM users;
COMMIT;
SET AUTOCOMMIT=1;

#12) Foreign Keys

CREATE TABLE addresses (
id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT,
street VARCHAR(255),
city VARCHAR(100),
state VARCHAR(100),
pincode VARCHAR(10),
CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id) 
ON DELETE CASCADE
ON UPDATE CASCADE
);

SELECT * FROM users;
SELECT * FROM addresses;

DELETE FROM users
WHERE id=6;

## Alter Command Practice

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO employees VALUES
(1,'Amit Sharma','IT',55000,'2022-01-10'),
(2,'Priya Singh','HR',42000,'2021-03-15'),
(3,'Rahul Verma','Finance',60000,'2020-07-22'),
(4,'Sneha Patil','IT',58000,'2023-02-18'),
(5,'Arjun Nair','Marketing',45000,'2022-09-30'),
(6,'Neha Joshi','IT',62000,'2019-11-05'),
(7,'Rohit Mehta','Sales',40000,'2021-06-12'),
(8,'Kavya Reddy','Finance',72000,'2018-04-19'),
(9,'Vikram Rao','IT',68000,'2020-12-25'),
(10,'Anjali Gupta','HR',39000,'2023-01-11'),
(11,'Suresh Yadav','Sales',41000,'2022-05-09'),
(12,'Pooja Desai','Marketing',47000,'2020-08-14'),
(13,'Manish Kumar','IT',75000,'2017-03-28'),
(14,'Divya Kapoor','Finance',69000,'2019-09-16'),
(15,'Karan Malhotra','HR',43000,'2021-11-03'),
(16,'Isha Sharma','Sales',39500,'2022-07-07'),
(17,'Aditya Roy','IT',81000,'2016-02-20'),
(18,'Meera Iyer','Marketing',48000,'2023-04-12'),
(19,'Nikhil Jain','Finance',71000,'2018-10-10'),
(20,'Ritu Verma','HR',44000,'2020-01-05'),
(21,'Aakash Singh','IT',64000,'2021-08-18'),
(22,'Simran Kaur','Marketing',46000,'2022-03-21'),
(23,'Deepak Chauhan','Sales',40500,'2019-06-30'),
(24,'Tanvi Shah','Finance',73000,'2017-12-09'),
(25,'Harsh Patel','IT',67000,'2020-02-14'),
(26,'Komal Arora','HR',45000,'2023-06-01'),
(27,'Yash Thakur','Sales',39000,'2021-04-27'),
(28,'Payal Bansal','Marketing',49500,'2019-07-17'),
(29,'Gaurav Mishra','IT',78000,'2016-09-23'),
(30,'Snehal Joshi','Finance',76000,'2018-01-30'),
(31,'Tanya Mehta','HR',42000,'2022-10-05'),
(32,'Rakesh Soni','Sales',41500,'2020-05-19'),
(33,'Bhavna Nair','IT',83000,'2015-11-11'),
(34,'Nitin Agarwal','Marketing',50000,'2023-03-03'),
(35,'Shruti Das','Finance',74500,'2017-08-25'),
(36,'Alok Pandey','IT',69000,'2019-12-12'),
(37,'Sakshi Gupta','HR',43500,'2021-02-22'),
(38,'Varun Khanna','Sales',42500,'2022-06-15'),
(39,'Pallavi Rao','Marketing',51000,'2020-09-09'),
(40,'Rohan Kapoor','IT',86000,'2014-04-04'),
(41,'Ishita Sen','Finance',75500,'2018-05-05'),
(42,'Mohit Arora','HR',44500,'2021-07-13'),
(43,'Ananya Bose','Marketing',52000,'2019-10-29'),
(44,'Tarun Gill','Sales',43000,'2020-11-20'),
(45,'Kirti Menon','IT',90000,'2013-01-17'),
(46,'Sahil Khan','Finance',78000,'2016-06-06'),
(47,'Juhi Chawla','HR',46000,'2023-05-08'),
(48,'Kunal Shah','Sales',44000,'2022-12-24'),
(49,'Mansi Tiwari','Marketing',53000,'2018-03-03'),
(50,'Prateek Jain','IT',87000,'2015-07-27');

SELECT * FROM company_employees;
## Easy 

## 1) Add column email VARCHAR(120)

ALTER TABLE employees
ADD COLUMN email VARCHAR(120);

## 2) Add column phone VARCHAR(15)

ALTER TABLE employees
ADD COLUMN phone VARCHAR(15);

## 3) Drop column phone

ALTER TABLE employees
DROP phone;

## 4) Rename column full_name → employee_name
ALTER TABLE employees
CHANGE COLUMN full_name employee_name VARCHAR(100);

## 5) Change salary datatype to INT

ALTER TABLE employees
MODIFY salary INT;

## 6) Increase size of department to VARCHAR(100)

ALTER TABLE employees
MODIFY department VARCHAR(100);

## Medium

## 1) Add NOT NULL to employee_name

ALTER TABLE employees
MODIFY employee_name VARCHAR(100) NOT NULL;

## 2) Add UNIQUE constraint on email

ALTER TABLE employees
MODIFY email VARCHAR(120) UNIQUE;

## 3) Add CHECK (salary > 20000)
ALTER TABLE employees
MODIFY salary INT CHECK (salary > 20000);

## 4) Add DEFAULT 'General' to department

ALTER TABLE employees
MODIFY department VARCHAR(50) DEFAULT "General";

## 5) Remove CHECK constraint on salary
ALTER TABLE employees
MODIFY salary INT;

## Hard

## 1) Add column bonus DECIMAL(8,2) AFTER salary

ALTER TABLE employees
ADD COLUMN bonus DECIMAL(8,2) AFTER salary;

## 2) Add column is_active BOOLEAN DEFAULT TRUE

ALTER TABLE employees
ADD COLUMN is_active BOOLEAN DEFAULT TRUE;

## 3) Drop column hire_date

ALTER TABLE employees
DROP hire_date;

## 4) Add column joining_date DATE

ALTER TABLE employees
ADD COLUMN joining_date DATE;

## 5) Rename table employees → company_employees

RENAME TABLE employees TO company_employees;

## 6) Add column last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP

ALTER TABLE company_employees
ADD COLUMN last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

## 7) Add column experience_years INT

ALTER TABLE company_employees
ADD COLUMN experience_years INT;

## 8) Add CHECK (experience_years >= 0)

ALTER TABLE company_employees
MODIFY experience_years INT CHECK(experience_years >= 0);

## 9) Add column manager_name VARCHAR(100)

ALTER TABLE company_employees
ADD COLUMN manager_name VARCHAR(100);

## 10) Drop column manager_name

ALTER TABLE company_employees
DROP manager_name;

## 11) Add column employment_type ENUM('Full-Time','Part-Time','Intern')

ALTER TABLE company_employees
ADD COLUMN  employment_type ENUM('Full-Time','Part-Time','Intern');

## 12) Change department to dept VARCHAR(100)

ALTER TABLE company_employees
CHANGE department dept VARCHAR(100);

## 13) Change salary to monthly_salary DECIMAL(12,2)

ALTER TABLE company.company_employees
CHANGE salary monthly_salary DECIMAL(12,2);

## 14) Change hire_date to joining_date DATE

ALTER TABLE company_employees
CHANGE hire_date joining_date DATE;

## 15) Change department to dept_code CHAR(10)

ALTER TABLE company_employees
CHANGE dept dept_code CHAR(10);

##########################################################

## JOINS in SQL

SELECT * FROM users;
SELECT * FROM addresses;

# INNER JOIN
## retrieve name & city of the user based on id & user_id

SELECT u.name, a.city , a.state, u.gender, a.id AS addresses_id
FROM users AS u
INNER JOIN addresses AS a
ON u.id=a.user_id;

## LEFT JOIN
SELECT u.name, a.city,u.salary,a.state
FROM users AS u
LEFT JOIN addresses AS a
ON u.id=a.user_id;

## RIGHT JOIN
SELECT u.name, a.city,u.salary,a.state
FROM users AS u
RIGHT JOIN addresses AS a
ON u.id=a.user_id;

## Union & Union All JOIN
SELECT email,name, "users" AS role FROM users
UNION
SELECT email,name,"admins" AS role FROM admin_users
ORDER BY name;

## Simple JOIN

SELECT *
FROM users
JOIN addresses
ON users.id=addresses.user_id;

## Self JOIN 

SELECT a.id,a.name AS user_name , b.name AS referred_name
FROM users AS a
INNER JOIN users AS b
ON a.referred_by_id=b.id;

######################################

## eg on JOINS

CREATE TABLE dept (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE emp (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT
);

INSERT INTO dept VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO emp VALUES
(101, 'Amit', 50000, 2),
(102, 'Neha', 60000, 1),
(103, 'Raj', 55000, 2),
(104, 'Sneha', 45000, 3),
(105, 'Vikas', 80000, 2),
(106, 'Priya', 75000, 1),
(107, 'Arjun', 90000, 3),
(108, 'Karan', 40000, NULL);

## 1) Show employee names with their department names.

SELECT e.emp_name AS employee_name, d.dept_name AS department
FROM emp AS e
INNER JOIN dept AS d
ON e.dept_id=d.dept_id;

## Display employee name, salary, and department name.

SELECT e.emp_name AS employee_name, e.salary, d.dept_name AS departments
FROM emp e
INNER JOIN dept d
ON e.dept_id=d.dept_id;

## List all employees working in the IT department.

SELECT e.emp_name AS eployee_name, d.dept_name AS departments
FROM emp e
JOIN dept d
ON e.dept_id=d.dept_id
WHERE dept_name = "IT";

## Show employees who belong to Finance.

SELECT e.emp_name AS employee_name, d.dept_name AS department
FROM emp e
JOIN dept d
ON e.dept_id=d.dept_id
WHERE dept_name = "Finance";

## Display employees earning more than 60,000 along with department name.

SELECT e.emp_name AS employee_name, e.salary AS salary, d.dept_name AS department
FROM emp e
JOIN dept d
ON e.dept_id=d.dept_id
WHERE salary > 60000;

## Count number of employees in each department.

SELECT d.dept_name AS department, COUNT(emp_id) AS emp_count  
FROM dept d
LEFT JOIN emp e
ON d.dept_id=e.dept_id
GROUP BY d.dept_name;

## Show the highest paid employee in each department.

SELECT d.dept_name AS department,e.emp_name AS employee_name, e.salary AS salary
FROM dept d
LEFT JOIN emp e
ON d.dept_id=e.dept_id
ORDER BY salary DESC
LIMIT 1;

## Show all employees and their department names (include employees without department).

SELECT e.emp_name AS employee_name, d.dept_name AS department_name
FROM emp e
LEFT JOIN dept d
ON e.dept_id=d.dept_id;

## Find employees who are not assigned to any department.

SELECT e.emp_name AS employee_name, d.dept_name AS department_name
FROM emp e
LEFT JOIN dept d
ON e.dept_id=d.dept_id
WHERE d.dept_name IS NULL;

## Show departments that currently have no employees.

SELECT dept_name AS department_name, e.emp_name AS employee_name
FROM dept d
LEFT JOIN emp e
ON d.dept_id=e.dept_id
WHERE e.emp_name IS NULL;

## Show all departments and employees (include departments without employees).

SELECT d.dept_name AS departments, e.emp_name AS employee_name
FROM dept d
RIGHT JOIN emp e
ON d.dept_id=e.dept_id;

## List departments with no employees using RIGHT JOIN.

SELECT d.dept_name AS department, e.emp_name AS employee_name
FROM emp e
RIGHT JOIN dept d
ON d.dept_id=e.dept_id
WHERE e.emp_name IS NULL;

ALTER TABLE emp ADD manager_id INT;

UPDATE emp SET manager_id = 105 WHERE emp_id IN (101,103);
UPDATE emp SET manager_id = 106 WHERE emp_id = 102;
UPDATE emp SET manager_id = 107 WHERE emp_id = 104;


SELECT * FROM emp;

## Show employee name and their manager name.

SELECT e.emp_name,m.emp_name
FROM emp e
LEFT JOIN emp m
ON e.manager_id=m.emp_id;

## SUBQUERIES

# Find employees who earn more than the average salary of all employees.

SELECT emp_name, (SELECT AVG(salary) FROM emp)
FROM emp
WHERE salary > (SELECT AVG(salary) FROM emp);

# Find the employee(s) who earn the highest salary.

SELECT emp_name, salary
FROM emp
ORDER BY salary DESC
LIMIT 1;

# Show employees who work in the same department as 'Amit'.

SELECT emp_name
FROM emp
WHERE dept_id = (SELECT dept_id FROM emp WHERE emp_name="Amit");


## more examples 
CREATE TABLE students_data (
    student_id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO students_data VALUES
(1, 'Amit'),
(2, 'Sara'),
(3, 'Rahul'),
(4, 'Neha'),
(5, 'John');

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);

INSERT INTO courses VALUES
(101, 'Math'),
(102, 'Science'),
(103, 'History'),
(104, 'Computer');


CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);


INSERT INTO enrollments VALUES
(1, 101),   -- Amit → Math
(1, 104),   -- Amit → Computer
(2, 102),   -- Sara → Science
(3, 101),   -- Rahul → Math
(3, 103);   -- Rahul → History
   

# Show the names of students and the courses they are enrolled in. Only include students who are enrolled in at least one course.

SELECT s.name, c.course_name
FROM students_data s
LEFT JOIN courses c
ON s.student_id = c.course_id;

SELECT * FROM enrollments;


