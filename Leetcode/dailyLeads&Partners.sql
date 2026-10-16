-- 1693. Daily Leads and Partners

-- For each date_id and make_name, find the number of distinct lead_id's and distinct partner_id's.
-- Return the result table in any order.

SELECT d.date_id AS date_id,
       d.make_name AS make_name,
       COUNT(DISTINCT d.lead_id) AS unique_lead,
       COUNT(DISTINCT d.partner_id) AS unique_partner
FROM DailySales d
GROUP BY d.date_id, d.make_name;