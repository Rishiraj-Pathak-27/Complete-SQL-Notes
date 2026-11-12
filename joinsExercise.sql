CREATE DATABASE joinsExercise;
USE joinsExercise;

## table department

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'IT', 'Mumbai'),
(2, 'HR', 'Delhi'),
(3, 'Finance', 'Pune'),
(4, 'Marketing', 'Bangalore'),
(5, 'Support', 'Chennai');

## table employees

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO employees VALUES
(101, 'Rohan', 70000, 1),
(102, 'Sneha', 55000, 2),
(103, 'Amit', 60000, 1),
(104, 'Priya', 45000, 3),
(105, 'Karan', 50000, NULL),
(106, 'Neha', 52000, 4),
(107, 'Arjun', 48000, 2);

## table projects

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO projects VALUES
(201, 'AI System', 101),
(202, 'HR Portal', 102),
(203, 'Banking App', 104),
(204, 'Website Revamp', 101),
(205, 'Marketing Ads', 106);


## Show employee name and their department name.

SELECT e.name AS emp_name, d.dept_name AS department_name
FROM employees AS e
INNER JOIN departments AS d
ON e.dept_id = d.dept_id;

## Show employees working in IT department along with their salaries.

SELECT e.name AS emp_name, d.dept_name AS department_name, e.salary AS emp_salary
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id
WHERE dept_name = "IT";

## Show all employees and their department names.
## Employees without a department should still appear.

SELECT e.name AS emp_name, d.dept_name AS department_name
FROM employees AS e
LEFT JOIN departments AS d
ON e.dept_id = d.dept_id;

#############################################################

## departments data

CREATE TABLE Departments_data (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO Departments_data VALUES
(1, 'Engineering', 'Pune'),
(2, 'HR', 'Mumbai'),
(3, 'Finance', 'Delhi'),
(4, 'Marketing', 'Bangalore');


## employee_data

CREATE TABLE Employees_data (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT
);

INSERT INTO Employees_data VALUES
(101, 'Amit', 60000, 1),
(102, 'Neha', 50000, 2),
(103, 'Raj', 70000, 1),
(104, 'Sneha', 45000, NULL),
(105, 'Karan', 55000, 4),
(106, 'Priya', 48000, 5);

## projects_data

CREATE TABLE Projects_data (
    proj_id INT PRIMARY KEY,
    proj_name VARCHAR(50),
    dept_id INT
);

INSERT INTO Projects_data VALUES
(201, 'AI System', 1),
(202, 'Recruitment Drive', 2),
(203, 'Budget Planning', 3),
(204, 'Ad Campaign', 4),
(205, 'Cloud Migration', 1);

## employee_project

CREATE TABLE Employee_Projects (
    emp_id INT,
    proj_id INT
);

INSERT INTO Employee_Projects VALUES
(101, 201),
(101, 205),
(102, 202),
(103, 201),
(105, 204),
(107, 203);

## Show employee names along with their department names.
SELECT d.dept_id, e.emp_name, d.dept_name
FROM Employees_data AS e
JOIN Departments_data AS d
ON e.dept_id = d.dept_id;

## Show all employees and their department names. Employees without a department should still appear
SELECT * 
FROM Employees_data AS e
LEFT JOIN Departments_data AS d
ON e.dept_id = d.dept_id;

## Display department names and the projects handled by each department.

SELECT d.dept_name, p.proj_name
FROM Departments_data AS d
LEFT JOIN Projects_data AS p
ON d.dept_id = p.dept_id;

## Show all projects and the department location managing them.

SELECT p.proj_name, d.location
FROM Projects_data AS p
JOIN Departments_data AS d
ON p.dept_id = d.dept_id;

## List employee names and the projects they are working on.

SELECT e.emp_name, p.proj_name
FROM Employees_data AS e
JOIN Projects_data AS p
ON e.dept_id = p.dept_id;

SELECT e.emp_name, p.proj_name
FROM Employees_data e
JOIN Employee_Projects ep ON e.emp_id = ep.emp_id
JOIN Projects_data p ON ep.proj_id = p.proj_id;


## Show all employees along with project names. Include employees who are not working on any project

SELECT e.emp_name, p.proj_name
FROM Employees_data AS e
LEFT JOIN Projects_data AS p
ON e.dept_id=p.dept_id;

## Display all projects along with employee names assigned to them. Include projects that have no employees.

SELECT p.proj_name, e.emp_name
FROM Employees_data AS e
RIGHT JOIN Projects_data AS p
ON e.dept_id=p.dept_id;

## Show employee name, salary, and department location.

SELECT e.emp_name,e.salary,d.location
FROM Employees_data AS e
JOIN Departments_data AS d
ON e.dept_id=d.dept_id;