SELECT Robberid,NickName,
(Age - NoYears) as years_not_in_prison
FROM Robbers 
WHERE NoYears > Age/2;

-- robberid |       nickname       | years_not_in_prison 
-- ----------+----------------------+---------------------
--         6 | Tony Genovese        |                  12
--        16 | King Solomon         |                  31