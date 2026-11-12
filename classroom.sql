CREATE DATABASE college;
USE college;

CREATE TABLE student(
	id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT NOT NULL
);

INSERT INTO student VALUES(1, "Rishiraj", 20);
INSERT INTO student VALUES(2, "Umesh", 50);
INSERT INTO student VALUES(3, "Sarita", 45);
INSERT INTO student VALUES(4, "Pawani", 13);

# to select & view all columns of table
SELECT * FROM student;


