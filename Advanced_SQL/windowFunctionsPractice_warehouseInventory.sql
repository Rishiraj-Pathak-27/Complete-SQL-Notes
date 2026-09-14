CREATE DATABASE IF NOT EXISTS warehouseInventory;
USE warehouseInventory;

# SCHEMA - 1 (warehouse)

CREATE TABLE warehouse
(
inventory_id INT PRIMARY KEY,
warehouse VARCHAR(50),
product VARCHAR(50),
stock INT, 
stock_value DECIMAL(10,2),
last_updated DATE
);

INSERT INTO warehouse VALUES
(301,"Mumbai","Laptop",20,1200000,'2026-01-05'),
(302,"Mumbai","Phone",50,750000,'2026-01-06'),
(303,"Mumbai","Tablet",30,450000,'2026-01-07'),
(304,"Pune","Laptop",15,900000,'2026-01-08'),
(305,"Pune","Phone",60,900000,'2026-01-09'),
(306,"Pune","Tablet",25,375000,'2026-01-10'),
(307,"Nagpur","Laptop",10,600000,'2026-01-11'),
(308,"Nagpur","Phone",40,600000,'2026-01-12'),
(309,"Nagpur","Tablet",20,300000,'2026-01-13'),
(310,"Mumbai","Monitor",25,500000,'2026-01-14'),
(311,"Pune","Monitor",30,600000,'2026-01-15'),
(312,"Nagpur","Monitor",15,300000,'2026-01-16');

SELECT * FROM warehouse;

DESCRIBE warehouse;

#----------------------------------------------------------------------------#

-- QUESTIONS & ANSWERS

-- 1) Show each product with the total stock value of its warehouse.

SELECT w.product,
	   w.warehouse,
	SUM(w.stock_value) OVER(
		PARTITION BY w.warehouse
    ) AS total_stock_value
FROM warehouse w;

-- 2) Show each product with the average number of stock units across warehouses.

SELECT w.product,
	   w.stock,
       w.warehouse,
	AVG(stock) OVER(
		PARTITION BY w.product
    ) AS avg_units
FROM warehouse w;

-- 3) Rank products inside each warehouse by stock_value, highest first.

SELECT w.product,
	   w.stock,
       w.warehouse,
       w.stock_value,
       RANK() OVER(
			PARTITION BY w.warehouse
            ORDER BY stock_value DESC
       ) AS rnk
FROM warehouse w;

-- 4) Find the top 2 products in each warehouse by stock_value, including ties.

SELECT w.*
FROM (
	SELECT w.*,
		DENSE_RANK() OVER(
			PARTITION BY w.warehouse
            ORDER BY w.stock_value DESC
        ) AS top_2_rnk
	FROM warehouse w
) w
WHERE w.top_2_rnk <= 2;

-- 5) Calculate running stock value in each warehouse ordered by last_updated.

SELECT w.*,
	SUM(w.stock_value) OVER(
		PARTITION BY w.warehouse
        ORDER BY w.last_updated
    ) AS running_stock
FROM warehouse w;

-- 6) Calculate stock_value / warehouse total stock value × 100 for every product.

SELECT w.inventory_id,
	   w.warehouse,
       w.product,
       w.stock,
       w.stock_value,
       w.last_updated,
       w.total_stock_value,
	   (w.stock_value / w.total_stock_value) * 100 AS contribution_per_warehouse
FROM (
	SELECT w.*,
		SUM(w.stock_value) OVER(
			PARTITION BY w.warehouse
		) AS total_stock_value
	FROM warehouse w
) w;

