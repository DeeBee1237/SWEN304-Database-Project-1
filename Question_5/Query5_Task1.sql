-- obtain the total number of robberies for each robber:
CREATE VIEW robberies_for_each_robber as (
select robberid, 
COUNT(robberid) as total_robberies
from accomplices
GROUP BY robberid);

-- obtain the average amount of robberies:
CREATE VIEW average_robberies as (
SELECT AVG (total_robberies) as average_robberies
FROM robberies_for_each_robber);

--       avg         
-- --------------------
--  3.5000000000000000
