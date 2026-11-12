CREATE DATABASE Joins;
USE Joins;

## Inner Join(Intersection)

CREATE TABLE student(
id INT PRIMARY KEY,
name VARCHAR(50)
);

INSERT INTO student
VALUES
(101,"Rishiraj"),
(102,"Yash"),
(103,"Rugved");

CREATE TABLE course (
course_id INT,
course_name VARCHAR(50)
);

INSERT INTO course
VALUES
(102,"Science"),
(105,"Maths"),
(103,"English"),
(107,"Hindi"),
(108,"Marathi"),
(102,"SST");


SELECT * 
FROM student AS s
INNER JOIN course AS c
ON s.id = c.id;

## Left Outer Join

SELECT *
FROM student s
LEFT JOIN course c
ON s.id=c.id;

## Right Outer Join

SELECT *
FROM student s
RIGHT JOIN course c
ON s.id=c.id;

## Full Outer Join

SELECT *
FROM student s
LEFT JOIN course c
ON s.id=c.course_id
UNION
SELECT *
FROM student s
RIGHT JOIN course c
ON s.id=c.course_id;

## Left Exclusive Join

SELECT * 
FROM student AS s
LEFT JOIN course AS c
ON s.id=c.course_id
WHERE c.course_id IS NULL;

## Right Exclusive Join

SELECT *
FROM student s
RIGHT JOIN course c
ON s.id = c.course_id
WHERE s.id IS NULL;

## Full Exclusive Join

SELECT *
FROM student s
LEFT JOIN course c
ON s.id = c.course_id
WHERE c.course_id IS NULL
UNION
SELECT *
FROM student s
RIGHT JOIN course c
ON s.id = c.course_id
WHERE s.id IS NULL;

## Self Join

CREATE TABLE employees(
id INT,
name VARCHAR(50),
manager_id INT
);

INSERT INTO employees 
VALUES
(101,"adam",103),
(102,"bob",104),
(103,"casey",NULL),
(104,"donald",103);

SELECT a.name AS manager_name, b.name
FROM employees AS a
JOIN employees AS b
ON a.id = b.manager_id;

## Union Join

SELECT name FROM student
UNION
SELECT name FROM employee;

## Union ALL Join

SELECT name FROM student
UNION ALL
SELECT name FROM employee;