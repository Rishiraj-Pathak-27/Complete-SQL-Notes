CREATE DATABASE IF NOT EXISTS salesPerformance;
USE salesPerformance;

# SCHEMA - 1 (sales)

CREATE TABLE sales
(
sales_id INT PRIMARY KEY,
salesperson VARCHAR(50),
sales_date DATE,
region VARCHAR(50),
amount DECIMAL(10,2)
);

INSERT INTO sales VALUES
(401,"Rahul",'2026-01-05',"West",10000),
(402,"Priya",'2026-01-07',"South",15000),
(403,"Amit",'2026-01-10',"Central",12000),
(404,"Rahul",'2026-01-15',"West",8000),
(405,"Priya",'2026-01-20',"South",10000),
(406,"Amit",'2026-01-22',"Central",15000),
(407,"Rahul",'2026-02-05',"West",12000),
(408,"Priya",'2026-02-08',"South",18000),
(409,"Amit",'2026-02-12',"Central",10000),
(410,"Rahul",'2026-02-20',"West",15000),
(411,"Priya",'2026-02-22',"South",12000),
(412,"Amit",'2026-02-25',"Central",20000);

SELECT * FROM sales;

DESCRIBE sales;

#-------------------------------------------------------------------------------#

# QUESTIONS & ANSWERS

-- 1) Show every sale with the salesperson's total sales.

SELECT s.*,
	SUM(s.amount) OVER(
		PARTITION BY s.salesperson
	) AS total_sales
FROM sales s;

-- 2) Calculate each salesperson's running sales ordered by sale_date.

SELECT s.*,
	SUM(s.amount) OVER(
		PARTITION BY s.salesperson
        ORDER BY s.sales_date
    ) AS running_sum
FROM sales s;

-- 3) Calculate running sales separately for each region.

SELECT s.*,
	SUM(s.amount) OVER(
		PARTITION BY s.region
        ORDER BY s.sales_date
    ) AS running_sales
FROM sales s;

-- 4) Rank salespeople by their total sales, highest first.

SELECT s.*
FROM (
	SELECT s.*,
		RANK() OVER(
            ORDER BY s.total_sales DESC
        ) AS rnk
	FROM (
		SELECT s.*,
			SUM(s.amount) OVER(
				PARTITION BY s.salesperson
            ) AS total_sales
		FROM sales s
    ) s
) s;

-- 5) Find the highest-performing salesperson in each region based on total sales.

SELECT s.*
FROM (
	SELECT s.*,
		ROW_NUMBER() OVER(
			PARTITION BY s.region
			ORDER BY s.total_sales
		) AS rno
	FROM (
		SELECT s.*,
			SUM(s.amount) OVER(
				PARTITION BY s.salesperson
			) AS total_sales
		FROM sales s    
    ) s
) s
WHERE rno <= 1;





