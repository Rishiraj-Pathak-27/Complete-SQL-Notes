-- 1661. Average Time of Process per Machine

-- There is a factory website that has several machines, each running one or more processes. Write a solution to find the average time each machine takes to complete a process.
-- The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run on that machine.
-- The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.
-- Return the result table in any order.

SELECT a.machine_id AS machine_id,
       ROUND(
            (SELECT AVG(a1.timestamp)
             FROM Activity a1
             WHERE a1.activity_type = 'end' AND a1.machine_id = a.machine_id
            ) - (
             SELECT AVG(a2.timestamp)
             FROM Activity a2
             WHERE a2.activity_type = 'start' AND a2.machine_id = a.machine_id
            ), 3
       ) AS processing_time
FROM Activity a
GROUP BY a.machine_id;