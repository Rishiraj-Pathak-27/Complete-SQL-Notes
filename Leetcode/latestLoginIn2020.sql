-- 1890. The Latest Login in 2020

-- Write a solution to report the latest login for all users in the year 2020. Do not include the users who did not login in 2020.
-- Return the result table in any order.

SELECT l.user_id AS user_id,
       MAX(l.last_stamp) AS time_stamp
FROM Logins l
WHERE YEAR(l.last_stamp) = 2020
GROUP BY l.user_id;
