CREATE DATABASE IF NOT EXISTS advWindowFunction;
USE advWindowFunction;

# SCHEMA 1 - (products) 

CREATE TABLE products (
product_id INT PRIMARY KEY,
product_category VARCHAR(50),
brand VARCHAR(50),
product_name VARCHAR(100),
price DECIMAL(10,2)
);

INSERT INTO products VALUES
(1, 'Laptop', 'Dell', 'Inspiron 15', 65000.00),
(2, 'Laptop', 'HP', 'Pavilion 14', 62000.00),
(3, 'Laptop', 'Lenovo', 'IdeaPad Slim 5', 58000.00),
(4, 'Laptop', 'Dell', 'Vostro 15', 72000.00),
(5, 'Laptop', 'HP', 'Victus 15', 85000.00),
(6, 'Mobile', 'Samsung', 'Galaxy A55', 42000.00),
(7, 'Mobile', 'Apple', 'iPhone 15', 70000.00),
(8, 'Mobile', 'OnePlus', 'OnePlus 13R', 45000.00),
(9, 'Mobile', 'Samsung', 'Galaxy S24', 75000.00),
(10, 'Mobile', 'Apple', 'iPhone 15 Pro', 125000.00),
(11, 'Tablet', 'Samsung', 'Galaxy Tab S9', 55000.00),
(12, 'Tablet', 'Apple', 'iPad Air', 60000.00),
(13, 'Tablet', 'Lenovo', 'Tab P12', 35000.00),
(14, 'Tablet', 'Samsung', 'Galaxy Tab A9', 18000.00),
(15, 'Tablet', 'Apple', 'iPad 10th Gen', 45000.00),
(16, 'Headphones', 'Sony', 'WH-1000XM5', 30000.00),
(17, 'Headphones', 'JBL', 'Tune 770NC', 85000.00),
(18, 'Headphones', 'Boat', 'Rockerz 550', 2500.00),
(19, 'Headphones', 'Sony', 'WH-CH720N', 12000.00),
(20, 'Headphones', 'JBL', 'Live 660NC', 15000.00),
(21, 'Monitor', 'LG', 'UltraGear 27', 28000.00),
(22, 'Monitor', 'Samsung', 'Odyssey G5', 32000.00),
(23, 'Monitor', 'Dell', 'S2721D', 25000.00),
(24, 'Monitor', 'LG', 'UltraWide 29', 35000.00),
(25, 'Monitor', 'Samsung', 'ViewFinity S6', 40000.00);

SELECT * FROM products;

DESCRIBE products;

#--------------------------------------------------------------------#

# QUESTION AND ANSWERS

-- I) FIRST_VALUE()

-- 1) For every product, display the first product alphabetically by product_name within its product_category.

SELECT p.*,
	FIRST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.product_name
    ) AS first_product_alphabetically
FROM products p;

-- 2) For every product, display the cheapest product_name in its product_category.

SELECT p.*,
	FIRST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price
    ) AS cheapest_product
FROM products p;

-- 3) For every product, display the cheapest price in its product_category using FIRST_VALUE().

SELECT p.*,
	FIRST_VALUE(p.price) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price
    ) AS cheapest_product
FROM products p;

-- 4) For every product, show the first product when products are ordered from highest price to lowest price within each category.

SELECT p.*,
	FIRST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price DESC
    ) AS first_product
FROM products p;

-- 5) For Mobile products only, show the cheapest mobile product using FIRST_VALUE(). Filter Mobile before the window function is evaluated.

SELECT p.*,
	FIRST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price
    ) AS cheapest_mobile
FROM products p
WHERE p.product_category = "Mobile";

-- 6) For every product, calculate the difference between its price and the cheapest price in its category.

SELECT p.product_id,
	   p.product_category,
       p.brand,
       p.product_name,
       p.price,
       p.cheapest_price,
       (p.price - p.cheapest_price) AS difference
FROM (
	SELECT p.*,
		FIRST_VALUE(p.price) OVER(
			PARTITION BY p.product_category
			ORDER BY p.price
		) AS cheapest_price
	FROM products p
) p;

-- ------------------------------------------------------------------------------------------------------

-- II) LAST_VALUE()

-- 1) For every product, find the most expensive product_name in its category using LAST_VALUE().

SELECT p.*,
	LAST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS most_exp_product
FROM products p;

-- 2) For every product, display the highest price in its category using LAST_VALUE().

SELECT p.*,
	LAST_VALUE(p.price) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS most_high_price
FROM products p;

-- 3) For every product, calculate how much cheaper it is than the most expensive product in its category.

SELECT x.*,
	   x.most_exp_product_price,
	   (x.most_exp_product_price - x.price) AS how_much_cheaper
FROM (
SELECT p.*,
	LAST_VALUE(p.price) OVER(
		PARTITION BY p.product_category
		ORDER BY p.price
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS most_exp_product_price
FROM products p
) x;

-- 4) For every product, find the last product alphabetically within its category using LAST_VALUE().

SELECT p.*,
	LAST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.product_name
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS alphabetically_last
FROM products p;

-- 5) For every Laptop, show the most expensive laptop. Make sure the complete partition is included in the frame.

SELECT p.*,
	LAST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price 
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS most_exp_laptop
FROM products p
WHERE p.product_category = "Laptop";

-- 6) Write two LAST_VALUE() queries: one using the default frame and one using ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING. Compare the results.

SELECT p.*,
	LAST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price
    ) AS default_frame,
    
    LAST_VALUE(p.product_name) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS complete_frame
FROM products p;

# default frame will acts as current row where the current row = resultant row
# ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING will give last value of the complete partition 

-- -----------------------------------------------------------------------------------------------------

-- III) NTH_VALUE()

-- 1) For every product, find the 2nd cheapest product in its category.

SELECT p.*,
	NTH_VALUE(p.product_name, 2) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS sec_cheapest_product
FROM products p;

-- 2) For every product, find the 3rd cheapest product in its category.

SELECT p.*,
	NTH_VALUE(p.product_name, 3) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS third_cheapest_product
FROM products p;

-- 3) For every product, find the 2nd most expensive product in its category using ORDER BY price DESC.

SELECT p.*,
	NTH_VALUE(p.product_name, 2) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS sec_most_exp_product
FROM products p;

-- 4) For Mobile products, display the 3rd most expensive mobile product. Filter Mobile before applying the window function.

SELECT p.*,
	NTH_VALUE(p.product_name, 3) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS third_most_exp_mobile
FROM products p
WHERE p.product_category = "Mobile";

-- 5) For every product, calculate the price difference between the current product and the 2nd most expensive product in its category.

SELECT p.*,
       (p.price - p.sec_most_exp_price) AS difference
FROM (
SELECT p.*,
	NTH_VALUE(p.price, 2) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS sec_most_exp_price
FROM products p
) p;

-- 6) For every product, show the 1st, 2nd and 3rd most expensive product names in its category using three NTH_VALUE() expressions.

SELECT p.*,
	NTH_VALUE(p.product_name,1) OVER w AS first_most_exp_product,
    NTH_VALUE(p.product_name,2) OVER w AS second_most_exp_product,
    NTH_VALUE(p.product_name,3) OVER w AS third_most_exp_product
FROM products p
WINDOW w AS (
	PARTITION BY p.product_category
	ORDER BY p.price DESC
	ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING 
);


-- --------------------------------------------------------------------------------------------------

-- IV) NTILE()

-- 1) Divide all products into 3 price buckets using NTILE(3), ordering price from highest to lowest.

SELECT p.*,
	NTILE(3) OVER(
        ORDER BY p.price DESC
    ) AS buckets
FROM products p;

-- 2) Using the above result, label bucket 1 as Expensive, bucket 2 as Mid Range, and bucket 3 as Cheaper using CASE.

SELECT p.*,
	   CASE WHEN p.buckets = 1 THEN "Expensive"
			WHEN p.buckets = 2 THEN "Mid Range"
            WHEN p.buckets = 3 THEN "Cheaper"
	   END category
FROM
(
	SELECT p.*,
		NTILE(3) OVER(
			ORDER BY p.price DESC
        ) AS buckets
	FROM products p
) p;

-- 3) Divide only Mobile products into 3 buckets based on price DESC and label the buckets Expensive Range Phone, Mid Range Phone and Cheaper Range Phone.

SELECT p.*,
	   CASE WHEN p.buckets = 1 THEN "Expensive"
			WHEN p.buckets = 2 THEN "Mid Range"
            WHEN p.buckets = 3 THEN "Cheaper"
	   END category
FROM
(
	SELECT p.*,
		NTILE(3) OVER(
			ORDER BY p.price DESC
        ) AS buckets
	FROM products p
    WHERE p.product_category = "Mobile"
) p;

-- 4) Divide products into 4 price buckets within each product_category using NTILE(4).

SELECT p.*,
	NTILE(4) OVER(
		PARTITION BY p.product_category
    ) AS buckets
FROM products p;

-- 5) For each product_category, identify products in the top price quartile (bucket 1 with price DESC).

SELECT p.*
FROM (
	SELECT p.*,
		NTILE(4) OVER(
			PARTITION BY p.product_category
            ORDER BY p.price DESC
        ) AS buckets
	FROM products p 
) p
WHERE p.buckets = 1;

-- 6) Use NTILE(5) within each category and return product_name, category, price and bucket.

SELECT p.product_name, 
	   p.product_category,
       p.price,
       p.buckets
FROM (
	SELECT p.*,
		NTILE(5) OVER(
				PARTITION BY p.product_category
		) AS buckets
	FROM products p
) p;

-- ---------------------------------------------------------------------------------

-- V) CUME_DIST()

-- 1) Calculate CUME_DIST() for all products ordered by price ASC.

SELECT p.*,
	CUME_DIST() OVER(
		ORDER BY p.price
    ) AS dist
FROM products p;

-- 2) Calculate CUME_DIST() for all products ordered by price DESC. Explain how the interpretation changes.

SELECT p.*,
	CUME_DIST() OVER(
		ORDER BY p.price DESC
    ) AS dist
FROM products p;

-- 3) For Mobile products, calculate CUME_DIST() by price ASC and display it as a percentage.

SELECT p.*,
	CUME_DIST() OVER(
		ORDER BY p.price
    ) AS dist
FROM products p
WHERE p.product_category = "Mobile";

-- 4) For every product category, calculate CUME_DIST() by price ASC using PARTITION BY.

SELECT p.*,
	CUME_DIST() OVER(
		PARTITION BY p.product_category
        ORDER BY p.price
    ) AS dist
FROM products p;

-- 5) Find products whose CUME_DIST() is 0.50 or less within their category. Use a subquery to filter the window result.

SELECT p.*
FROM (
	SELECT p.*,
		CUME_DIST() OVER(
			PARTITION BY p.product_category
            ORDER BY p.price
        ) AS dist
	FROM products p
) p
WHERE p.dist <= 0.50;

-- 6) Within each category, label products as Lower Quarter (<=0.25), Lower-Middle (>0.25 and <=0.50), Upper-Middle (>0.50 and <=0.75), or Upper Quarter (>0.75).

SELECT p.*,
	   CASE WHEN p.dist <= 0.25 THEN "Lower Quarter"
		    WHEN p.dist > 0.25 AND p.dist <= 0.50 THEN "Lower-Middle Quarter"
            WHEN p.dist > 0.50 AND p.dist <= 0.75 THEN "Upper-Middle Quarter"
            WHEN p.dist > 0.75 THEN "Upper Quarter" 
	   END category
FROM (
	SELECT p.*,
		CUME_DIST() OVER(
			PARTITION BY p.product_category
            ORDER BY p.price
        ) AS dist
	FROM products p
) p;

-- -------------------------------------------------------------------------------

-- IV) COMBINED ADVANCED CHALLENGES

-- 1) For every product, show the cheapest product, most expensive product, and current product price within its category using FIRST_VALUE(), LAST_VALUE(), and the current row.

SELECT p.*,
	FIRST_VALUE(p.price) OVER (
		PARTITION BY p.product_category
        ORDER BY p.price
    ) AS cheapest_product,
    
    LAST_VALUE(p.price) OVER (
		PARTITION BY p.product_category
		ORDER BY p.price 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS expensive_product,
    
    p.price AS current_price
FROM products p;

-- 2) For every category, display the 2nd most expensive and 2nd cheapest product using NTH_VALUE().

SELECT p.*,
	NTH_VALUE(p.product_name,2) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	) AS sec_most_exp_product,
    
    NTH_VALUE(p.product_name,2) OVER(
		PARTITION BY p.product_category
        ORDER BY p.price
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS sec_most_cheapest_product
FROM products p;