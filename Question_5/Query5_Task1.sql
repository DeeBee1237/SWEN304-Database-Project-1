------------------------
-- step wise approach --
------------------------

-- obtain the total number of robberies for each robber
-- next to their individual earnings:
CREATE VIEW robberies_for_each_robber as (
select robberid, 
COUNT(robberid) as total_robberies,
SUM(share) as total_earnings
from accomplices
GROUP BY robberid);

-- obtain the average amount of robberies:
CREATE VIEW average_robberies as (
SELECT AVG (total_robberies) as average_robberies
FROM robberies_for_each_robber);

-- find the active robbers who participated in more robberies than the average:
CREATE VIEW active_robbers as (
select * from robberies_for_each_robber 
WHERE total_robberies > 
(select average_robberies 
from average_robberies));

-- create a view with only the nicknames of those robbers
-- in descending order of earnings:
CREATE VIEW nicknames as (
select nickname
from active_robbers a 
JOIN robbers r
ON r.robberid = a.robberid
WHERE r.noyears = 0
ORDER BY total_earnings DESC);

-- finally display the results with a simple select statement:
select * from nicknames;


----------------------
-- The single query --
----------------------

select nickname
from 
(select * 
from (select robberid, 
COUNT(robberid) as total_robberies,
SUM(share) as total_earnings
from accomplices
GROUP BY robberid) as robberies_for_each_robber
WHERE total_robberies > (SELECT AVG (total_robberies) 
FROM (select robberid, 
COUNT(robberid) as total_robberies,
SUM(share) as total_earnings
from accomplices
GROUP BY robberid) as robberies_for_each_robber)) as active_robbers
JOIN robbers r
ON r.robberid = active_robbers.robberid
WHERE r.noyears = 0
ORDER BY total_earnings DESC;


--       nickname       
-- ----------------------
--  Bonnie              
--  Clyde               
--  Sonny Genovese      
-- (3 rows)