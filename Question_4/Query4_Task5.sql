-- Alternative single, nested query:
-- SELECT r.robberid as robber_id,
-- r.nickname as nickname,
-- i.earnings as individual_earnings
-- FROM (SELECT * FROM 
-- (SELECT robberid,
-- SUM(share) as earnings 
-- FROM accomplices 
-- GROUP BY robberid) 
-- as robbery_earnings
-- WHERE earnings > 30000) as i
-- JOIN Robbers r
-- ON i.robberid = r.robberid
-- ORDER BY individual_earnings DESC;

DROP VIEW IF EXISTS individualEarningsOver3k CASCADE;
-- Create a view that displays the robber id for all robbers who 
-- earned over 30,000 dollars, as well as the total amount they made.
CREATE VIEW individualEarningsOver3k as (
SELECT * FROM 
(SELECT robberid,
SUM(share) as earnings 
FROM accomplices 
GROUP BY robberid) 
as robbery_earnings
WHERE earnings > 30000);

-- what the view looks like:

-- robberid | earnings 
-- ----------+----------
--         8 |    31800
--        17 |    52601
--        15 |    61448
--        10 |    40085
--         4 |    39169
--        16 |    59726
--         3 |    42667
--         5 |    70000

-- now join this view with the Robbers table, to obtain the nickname
-- as well as the robbers id, and total individual earnings:
SELECT r.robberid as robber_id,
r.nickname as nickname,
i.earnings as individual_earnings
FROM individualEarningsOver3k i
JOIN Robbers r
ON i.robberid = r.robberid
ORDER BY individual_earnings DESC;

-- This query yields the following results: 

--  robber_id |       nickname       | individual_earnings 
-- -----------+----------------------+---------------------
--          5 | Mimmy The Mau Mau    |               70000
--         15 | Boo Boo Hoff         |               61448
--         16 | King Solomon         |               59726
--         17 | Bugsy Siegel         |               52601
--          3 | Lucky Luchiano       |               42667
--         10 | Bonnie               |               40085
--          4 | Anastazia            |               39169
--          8 | Clyde                |               31800