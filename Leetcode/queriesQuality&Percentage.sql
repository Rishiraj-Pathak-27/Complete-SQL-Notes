-- 1211. Queries Quality and Percentage

-- We define query quality as:
-- The average of the ratio between query rating and its position.
-- We also define poor query percentage as:
-- The percentage of all queries with rating less than 3.
-- Write a solution to find each query_name, the quality and poor_query_percentage.
-- Both quality and poor_query_percentage should be rounded to 2 decimal places.
-- Return the result table in any order.

SELECT q.query_name AS query_name,
       ROUND(SUM(q.rating / q.position) / COUNT(*),2) AS quality,
       ROUND((COUNT(CASE
                       WHEN q.rating < 3 THEN 1
                   END) / COUNT(*)) * 100,2) AS poor_query_percentage
FROM Queries q
GROUP BY q.query_name;