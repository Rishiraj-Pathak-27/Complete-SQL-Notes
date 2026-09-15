CREATE DATABASE IF NOT EXISTS advWindowFunctions;
USE advWindowFunctions;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_category VARCHAR(50),
    brand VARCHAR(50),
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

INSERT INTO products
(product_id, product_category, brand, product_name, price)
VALUES
(1,'Laptop','Dell','Inspiron 15',65000),
(2,'Laptop','HP','Pavilion 14',62000),
(3,'Laptop','Lenovo','IdeaPad Slim 5',58000),
(4,'Laptop','Dell','Vostro 15',72000),
(5,'Laptop','HP','Victus 15',85000),
(6,'Mobile','Samsung','Galaxy A55',42000),
(7,'Mobile','Apple','iPhone 15',70000),
(8,'Mobile','OnePlus','OnePlus 13R',45000),
(9,'Mobile','Samsung','Galaxy S24',75000),
(10,'Mobile','Apple','iPhone 15 Pro',125000),
(11,'Tablet','Samsung','Galaxy Tab S9',55000),
(12,'Tablet','Apple','iPad Air',60000),
(13,'Tablet','Lenovo','Tab P12',35000),
(14,'Tablet','Samsung','Galaxy Tab A9',18000),
(15,'Tablet','Apple','iPad 10th Gen',45000),
(16,'Headphones','Sony','WH-1000XM5',30000),
(17,'Headphones','JBL','Tune 770NC',8500),
(18,'Headphones','Boat','Rockerz 550',2500),
(19,'Headphones','Sony','WH-CH720N',12000),
(20,'Headphones','JBL','Live 660NC',15000),
(21,'Monitor','LG','UltraGear 27',28000),
(22,'Monitor','Samsung','Odyssey G5',32000),
(23,'Monitor','Dell','S2721D',25000),
(24,'Monitor','LG','UltraWide 29',35000),
(25,'Monitor','Samsung','ViewFinity S6',40000);

SELECT * FROM products;

DESCRIBE products;


-- ----------------------------------------------------------------------

# ADVANCED WINDOW FUNCTIONS

# 1) FIRST_VALUE()

-- this function is used to return the first value from the record of the particular column entered in FIRST_VALUE() function

-- EG. WAQ to display the most expensive product under each category.

SELECT p.*,
	FIRST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price DESC
    ) AS most_exp_product
FROM products p;

# 2) LAST_VALUE()

-- this functions is used to return the last value from the record of the particular column entered in LAST_VALUE() function

-- EG. WAQ to display the least expensive product under each category.

# Normal Way which is not getting ans as expected, so for that we use Frame Clause

SELECT p.*,
	LAST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price DESC
    ) AS least_exp_product
FROM products p; 

-- Frame Clause Types:  
  
# 1) starting to -> current row   

SELECT p.*,
	LAST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price DESC
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS least_exp_product
FROM products p;

# 2) start to -> end of partition

SELECT p.*,
	LAST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price DESC
		ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS least_exp_product
FROM products p;

# 3) current row -> end of partition

SELECT p.*,
	LAST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price DESC
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    ) AS least_exp_product
FROM products p;

# 4) Nth precedings -> end of partition

SELECT p.*,
	LAST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price DESC
		ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING
    ) AS least_exp_product
FROM products p;

# 5) starting to -> Nth end of partition

SELECT p.*,
	LAST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price DESC
		ROWS BETWEEN UNBOUNDED PRECEDING AND 3 FOLLOWING
    ) AS least_exp_product
FROM products p;

-- Eg) find the most expensive product in its category using LAST_VALUE().

SELECT p.*,
	LAST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS most_exp_product
FROM products p;














