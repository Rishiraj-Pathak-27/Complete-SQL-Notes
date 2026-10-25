# there are few aggregate functions in sql (built in functions)

#1. count()
#2. max()
#3. min()
#4. avg()
#5. sum()
#6. round()

CREATE DATABASE myBusiness;

USE myBusiness;

CREATE TABLE employeesTrack (
e_id INT,
e_name VARCHAR(100),
e_age INT NOT NULL CHECK (e_age >= 18),
e_gender VARCHAR(20),
e_salary INT NOT NULL,
e_post VARCHAR(50)
);


INSERT INTO employeesTrack (e_id, e_name, e_age, e_gender, e_salary, e_post) 
VALUES
(1,"John Duckett",20,"male",75000,"technical"),
(2, "Deepika Jaiswal", 34, "female", 50000, "sales"),
(3, "Raghav Garg", 38, "male", 100000, "content creator"),
(4, "Harris Ali Khan", 28, "male", 125000, "content creator"),
(5, "Charlie Washington", 40, "female", 35000, "editor"),
(6, "Ben Stokes", 45, "male", 150000, "analyst");

SELECT * FROM employeesTrack;
SELECT COUNT(*) FROM employeesTrack;
SELECT SUM(e_age) FROM employeesTrack;
SELECT AVG(e_age) FROM employeesTrack;
SELECT MAX(e_salary) FROM employeesTrack;
SELECT MIN(e_salary) FROM employeesTrack;
SELECT ROUND(AVG(e_age)) FROM employeesTrack;
