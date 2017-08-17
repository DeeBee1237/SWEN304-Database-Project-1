-- The inner query finds all banknames of banks that 
-- have branches in chicago.

-- the outer query finds all bankname,city tuples of banks 
-- not in that group 

SELECT bankname,city --,noaccounts -- add this in to actually see increasing order of accounts
FROM Banks 
WHERE bankname NOT IN (
SELECT bankname
FROM Banks 
where city = 'Chicago')
ORDER BY noaccounts; 

--       bankname       |         city         
-- ----------------------+----------------------
--  EasyLoan Bank        | Evanston            
--  Gun Chase Bank       | Deerfield           
--  Bankrupt Bank        | Evanston            
--  Gun Chase Bank       | Evanston            