CREATE DATABASE collegeTwo;
USE collegeTwo;

CREATE TABLE student (
rollno INT PRIMARY KEY,
name VARCHAR(50),
marks INT NOT NULL,
grade VARCHAR(1),
city VARCHAR(50),
student_age VARCHAR(50)
);

INSERT INTO student
VALUES
(101,"Rishiraj Pathak",90,'A',"Nagpur"),
(102,"Yash Deshkar",80,'B',"Nagpur"),
(103,"Rugved Khapekar",100,'A',"Nagpur"),
(104,"Utkarsh Patrikar",98,'A',"Mumbai"),
(105,"Mohit Agrawal",88,'B',"Pune"),
(106,"Harsh Dhole",78,'C',"Pune"),
(107,"Shreyash Chimote",85,'B',"Pune");

SELECT * FROM student;

SELECT name,marks FROM student;
SELECT * FROM student;
SELECT DISTINCT city FROM student;

SELECT * FROM student WHERE marks > 80;
SELECT * FROM student WHERE city = "Nagpur";
SELECT * FROM student WHERE grade = 'B' AND city = "Nagpur";

SELECT * FROM student WHERE grade IN ('A','C');
SELECT * FROM student WHERE city NOT IN ("Nagpur","Tirora");

SELECT * FROM student WHERE marks+10 > 100;