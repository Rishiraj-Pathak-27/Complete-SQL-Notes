-- 3497. Analyze Subscription Conversion 

-- A subscription service wants to analyze user behavior patterns. The company offers a 7-day free trial, after which users can subscribe to a paid plan or cancel. Write a solution to:
-- Find users who converted from free trial to paid subscription
-- Calculate each user's average daily activity duration during their free trial period (rounded to 2 decimal places)
-- Calculate each user's average daily activity duration during their paid subscription period (rounded to 2 decimal places)
-- Return the result table ordered by user_id in ascending order.

SELECT u.user_id AS user_id,
       ROUND(AVG(CASE
                     WHEN u.activity_type = 'free_trial' THEN u.activity_duration
                 END),2) AS trial_avg_duration,

        ROUND(AVG(CASE
                      WHEN u.activity_type = 'paid' THEN u.activity_duration
                  END),2) AS paid_avg_duration
FROM UserActivity u
GROUP BY u.user_id
HAVING SUM(CASE
               WHEN u.activity_type = 'free_trial' THEN 1
               ELSE 0
           END) > 0 AND
        
       SUM(CASE
               WHEN u.activity_type = 'paid' THEN 1
               ELSE 0
           END) > 0
ORDER BY u.user_id;
