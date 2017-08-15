SELECT bankname,security 
FROM Banks 
WHERE city = 'Chicago' 
AND noaccounts>9000; 

--        bankname       |       security       
-- ----------------------+----------------------
--  NXP Bank             | very good           
--  Loanshark Bank       | excellent           
--  Inter-Gang Bank      | excellent           
--  Penny Pinchers       | weak                
--  Dollar Grabbers      | very good           
--  PickPocket Bank      | weak                
--  Hidden Treasure      | excellent           
-- (7 rows)