------------------------
-- step wise approach --
------------------------

-- this view shows banks that were robbed next to their security level
-- and the amount stolen from that bank. This is done by joining robberies 
-- and robberies:
CREATE VIEW robberiesGroupedBySecurity as (
SELECT b.bankname as bankname,
b.city as city,
b.security as security,
r.amount as amount
FROM Banks b 
JOIN Robberies r 
ON b.bankname = r.bankname 
AND b.city = r.city
ORDER BY b.security);

-- now create the view that contains security levels, all robberies for branches 
-- of that security level, and average amount stolen during those robberies:
CREATE VIEW securityLevelAndRobberies as (
SELECT security as security_level, 
COUNT(security) as total_number_of_robberies,
AVG(amount) as average_amount_stolen
FROM robberiesGroupedBySecurity
GROUP BY security
ORDER BY total_number_of_robberies DESC);

-- the final query:
SELECT * FROM securityLevelAndRobberies;

----------------------
-- The single query --
----------------------

SELECT security as security_level, 
COUNT(security) as total_number_of_robberies,
AVG(amount) as average_amount_stolen
FROM (SELECT b.bankname as bankname,
b.city as city,
b.security as security,
r.amount as amount
FROM Banks b 
JOIN Robberies r 
ON b.bankname = r.bankname 
AND b.city = r.city
ORDER BY b.security) as robberiesGroupedBySecurity
GROUP BY security
ORDER BY total_number_of_robberies DESC;


--    security_level    | total_number_of_robberies | average_amount_stolen  
-- ----------------------+---------------------------+------------------------
--  excellent            |                        12 |     39238.083333333333
--  weak                 |                         4 |  2299.5000000000000000
--  very good            |                         3 | 12292.4266666666666667
--  good                 |                         2 |  3980.0000000000000000
