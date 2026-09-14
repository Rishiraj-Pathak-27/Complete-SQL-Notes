CREATE DATABASE IF NOT EXISTS logisticsDelivery;
USE logisticsDelivery;

# SCHEMA - 1 (drivers)

CREATE TABLE drivers
(
driver_id INT PRIMARY KEY,
driver_name VARCHAR(50),
city VARCHAR(50)
);

INSERT INTO drivers VALUES 
(1,"Ramesh","Mumbai"),
(2,"Suresh","Pune"),
(3,"Akash","Nagpur"),
(4,"Vikram","Mumbai"),
(5,"Rohit","Pune"),
(6,"Anil","Nagpur");

# SCHEMA - 2 (deliveries)

CREATE TABLE deliveries
(
delivery_id INT PRIMARY KEY,
driver_id INT, 
delivery_date DATE,
delivery_time_hours DECIMAL(5,2),
delivery_value DECIMAL(10,2),
status VARCHAR(20)
);

## Forgot to link table using foreign key (attr = "driver_id")

ALTER TABLE deliveries
ADD CONSTRAINT fk_driver_id
FOREIGN KEY (driver_id)
REFERENCES drivers(driver_id);

INSERT INTO deliveries VALUE
(201,1,'2026-01-05',4.5,5000,"Delivered"),
(202,1,'2026-01-06',6.0,7000,"Delayed"),
(203,1,'2026-01-10',3.5,4000,"Delivered"),
(204,1,'2026-01-12',5.0,8000,"Delivered"),
(205,1,'2026-01-15',7.0,6000,"Delayed"),
(206,1,'2026-01-18',4.0,5000,"Delivered"),
(207,1,'2026-01-20',5.5,9000,"Delivered"),
(208,1,'2026-01-22',4.0,6000,"Delivered"),
(209,1,'2026-01-25',6.0,7000,"Delayed"),
(210,1,'2026-01-28',3.0,5000,"Delivered"),
(211,1,'2026-02-02',5.5,7000,"Delivered"),
(212,1,'2026-02-05',4.5,6000,"Delayed");

## Updating the driver_id for each delivery_id

UPDATE deliveries
SET driver_id = 2
WHERE delivery_id = 202;

UPDATE deliveries
SET driver_id = 1
WHERE delivery_id = 203;

UPDATE deliveries
SET driver_id = 3
WHERE delivery_id = 204;

UPDATE deliveries
SET driver_id = 4
WHERE delivery_id = 205;

UPDATE deliveries
SET driver_id = 2
WHERE delivery_id = 206;

UPDATE deliveries
SET driver_id = 5
WHERE delivery_id = 207;

UPDATE deliveries
SET driver_id = 3
WHERE delivery_id = 208;

UPDATE deliveries
SET driver_id = 1
WHERE delivery_id = 209;

UPDATE deliveries
SET driver_id = 6
WHERE delivery_id = 210;

UPDATE deliveries
SET driver_id = 4
WHERE delivery_id = 211;

UPDATE deliveries
SET driver_id = 5
WHERE delivery_id = 212;

-- to show schema info and whole schema

SELECT * FROM drivers;
SELECT * FROM deliveries;

DESCRIBE drivers;
DESCRIBE deliveries;

#-----------------------------------------------------------------------------------#

-- QUESTIONS & ANSWERS

-- 1) Show every delivery with the total value delivered by its driver.

SELECT d.*,
	SUM(d.delivery_value) OVER(
		PARTITION BY d.driver_id
    ) AS total_value
FROM deliveries d;

-- 2) Show every delivery with its driver's average delivery time.

SELECT d.*,
	AVG(d.delivery_time_hours) OVER(
		PARTITION BY d.driver_id
	) AS avg_delivery_time
FROM deliveries d;

-- 3) Calculate running delivery value for each driver ordered by delivery_date.

SELECT d.*,
	SUM(d.delivery_value) OVER(
		PARTITION BY d.driver_id
        ORDER BY d.delivery_date
    ) AS running_delivery
FROM deliveries d;

-- 4) Rank drivers based on their total delivery value, highest first.

SELECT d.delivery_id,
	   d.driver_id,
       d.delivery_time_hours,
       d.delivery_date,
       d.delivery_value,
       d.status,
       d.total_delivery_value,
       d.rnk
FROM (
	SELECT d.*,
		DENSE_RANK() OVER(
			ORDER BY d.total_delivery_value DESC
        ) AS rnk
	FROM (
		SELECT d.*,
			SUM(d.delivery_value) OVER(
				PARTITION BY d.driver_id
			) AS total_delivery_value
		FROM deliveries d
	) d
) d;

-- 5) Rank each driver's deliveries from fastest to slowest.

SELECT d.*,
	RANK() OVER(
		PARTITION BY d.driver_id
        ORDER BY d.delivery_time_hours DESC
    ) AS rnk
FROM deliveries d;

-- 6) Find each driver's top 2 deliveries by delivery_value, including ties.

SELECT d.delivery_id,
	   d.driver_id,
       d.delivery_date,
       d.delivery_time_hours,
       d.delivery_value,
       d.status,
       d.top_2_rnk
FROM (
	SELECT d.*,
		DENSE_RANK() OVER(
			PARTITION BY d.driver_id
			ORDER BY d.delivery_value DESC
		) AS top_2_rnk
	FROM deliveries d
) d
WHERE d.top_2_rnk <= 2;

-- 7) Show delivery time, driver average time, and difference = delivery time − driver average.

SELECT d1.delivery_id,
	   d2.driver_name,
	   d1.driver_id,
       d1.delivery_date,
       d1.delivery_time_hours,
       d1.delivery_value,
       d1.status,
       d1.driver_avg_time
FROM (
	SELECT d1.*,
		AVG(d1.delivery_time_hours) OVER(
			PARTITION BY d1.driver_id
		) AS driver_avg_time
	FROM deliveries d1
) d1
JOIN drivers d2
ON d1.driver_id = d2.driver_id;


-- Using the drivers and deliveries tables from Scenario 2, create one report containing:
-- • driver_name
-- • city
-- • total_delivery_value
-- • average_delivery_time
-- • fastest_delivery
-- • slowest_delivery
-- • running_delivery_value
-- • delivery_rank

SELECT d2.driver_name, 
	   d2.city,
	   d1.total_delivery_value,
       d1.avg_delivery_time,
       d1.fastest_delivery,
       d1.slowest_delivery,
       d1.delivery_date,
       d1.delivery_value,
       d1.running_delivery_value,
       d1.delivery_rank
FROM (
	SELECT d1.*,
		SUM(d1.delivery_value) OVER(
			PARTITION BY d1.driver_id
		) AS total_delivery_value,
        
        AVG(d1.delivery_time_hours) OVER(
			PARTITION BY d1.driver_id
        ) AS avg_delivery_time,
        
		MIN(d1.delivery_time_hours) OVER(
			PARTITION BY d1.driver_id
        ) AS fastest_delivery,
        
		MAX(d1.delivery_time_hours) OVER(
			PARTITION BY d1.driver_id
        ) AS slowest_delivery,
        
        SUM(d1.delivery_value) OVER(
			PARTITION BY d1.driver_id
            ORDER BY d1.delivery_date 
        ) AS running_delivery_value,
        
		RANK() OVER(
			PARTITION BY d1.driver_id
            ORDER BY d1.delivery_value DESC
		) AS delivery_rank
        
	FROM deliveries d1
    
) d1 
JOIN drivers d2
ON d1.driver_id = d2.driver_id
ORDER BY d1.driver_id, d1.delivery_date;


