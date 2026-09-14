-- 595. Big Countries

-- A country is big if:
-- it has an area of at least three million (i.e., 3000000 km2), or
-- it has a population of at least twenty-five million (i.e., 25000000).
-- Write a solution to find the name, population, and area of the big countries.
-- Return the result table in any order.

SELECT w.name AS name,
       w.population AS population,
       w.area AS area
FROM World w
WHERE w.area >= 3000000 OR w.population >= 25000000;