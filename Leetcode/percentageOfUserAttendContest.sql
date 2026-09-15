-- 1633. Percentage of Users Attended a Contest

-- Write a solution to find the percentage of the users registered in each contest rounded to two decimals.
-- Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.

SELECT r.contest_id AS contest_id,
       ROUND((COUNT(r.user_id) * 100) / (
        SELECT COUNT(*)
        FROM Users u
       ), 2) AS percentage
FROM Register r
GROUP BY r.contest_id
ORDER BY r.contest_id ASC, percentage DESC;