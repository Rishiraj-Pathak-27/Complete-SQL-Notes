-- 1407. Top Travellers

-- Write a solution to report the distance traveled by each user.
-- Return the result table ordered by travelled_distance in descending order, if two or more users traveled the same distance, order them by their name in ascending order.

SELECT u.name AS name,
       CASE 
           WHEN r.distance IS NOT NULL THEN SUM(r.distance)
           WHEN r.distance IS NULL THEN 0
       END travelled_distance
FROM Users u
LEFT JOIN Rides r
ON u.id=r.user_id
GROUP BY u.id,u.name
ORDER BY travelled_distance DESC, u.name ASC;  