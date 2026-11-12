USE accounts;

# Primary key Constraint
# CREATE TABLE test (
# id INT,     # test (id) is a primary key s
# age INT,
# name VARCHAR(100),
# PRIMARY KEY (id,age)
# );


# Foreign Key Constraint
# CREATE TABLE temp (
# cityId INT,
# age INT NOT NULL,
# name VARCHAR(50),
# FOREIGN KEY (cityId) references test(id)      # cityId is a foreign key
# );

CREATE TABLE temp2(
id INT,
name VARCHAR(100),
salary INT DEFAULT 30000,
PRIMARY KEY (id)
);

CREATE TABLE temp3 (
id INT,
name VARCHAR(100),
feespaid INT DEFAULT 0.00
);

INSERT INTO temp3 (id,name) VALUES(1,"Rishiraj");
INSERT INTO temp3 (id,name,feespaid) VALUES(2,"John",100000);

SELECT * FROM temp3;



# data for table temp2
INSERT INTO temp2 (id,name) VALUES(1,"Rishiraj");
INSERT INTO temp2 VALUES(2,"YASH",25000);

# data for table test
# INSERT INTO test VALUES(1,20,"RISHIRAJ");
# INSERT INTO test VALUES(2,20,"SHREYASH");


SELECT * FROM test;
SELECT * FROM temp2;
