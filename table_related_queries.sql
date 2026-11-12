# creates database accounts if not exists before
CREATE DATABASE IF NOT EXISTS accounts;

USE accounts;

# to define table schema we use
# syntax:-

# CREATE TABLE table_name (
# column_name datatype constraints
# );

CREATE TABLE fees (
	id INT PRIMARY KEY,
    name VARCHAR(100),
    feespaid INT NOT NULL
);

# syntax to insert data in table
# INSERT INTO table_name (col1,col2,col3) VALUES(val1, val2, val3);

INSERT INTO fees (id,name,feespaid) VALUES(1, "Rishiraj", 175000.00);
INSERT INTO fees (id,name,feespaid) VALUES(2, "Yash", 99000.000);
INSERT INTO fees (id,name,feespaid) VALUES(3, "Rugved", 15000.000);
INSERT INTO fees (id,name,feespaid) VALUES(4, "Karan",250000.00);
# where (id,name,feespaid) is not necessary

# used to display the table
SELECT * FROM fees;  

SHOW TABLES; 

SET SQL_SAFE_UPDATES = 0;

UPDATE student
SET grade = "O"
WHERE grade = "A"; 


SELECT * FROM student;

UPDATE student 
SET marks = 95
WHERE marks = 100 AND 98;

UPDATE student 
SET marks = marks + 5;

# DELETE Command

DELETE FROM student
WHERE marks > 100;

DELETE FROM student
WHERE marks < 90;



# UPDATE Command

USE collegeTwo;

DELETE FROM student
WHERE rollno = 105;

SELECT * FROM STUDENT;

###########################################

## Alter Command

USE collegeTwo;

SELECT * FROM student;

## 1. ADD Column

ALTER TABLE student
ADD age INT NOT NULL DEFAULT 19;

## 2. DROP Column

ALTER TABLE student
DROP age;

## 3. RENAME Table

ALTER TABLE student
RENAME TO student_details;

ALTER TABLE student_details
RENAME TO student;

## 4. CHANGE Column Name

ALTER TABLE student
CHANGE age student_age INT NOT NULL;

## 5. MODIFY Datatype/Constraint

ALTER TABLE student
MODIFY student_age VARCHAR(50);

UPDATE student
SET student_age = 20
WHERE rollno = 101;

## 6. TRUNCATE Table

TRUNCATE TABLE student;

################################################################





