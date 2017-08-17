-- first obtain the id of the robber calamity jane:
-- select robberid 
-- from robbers 
-- where nickname = 'Calamity Jane';

-- robberid 
-- ----------
--         9

-- now use that id to obtain the unique banknames where 
-- calamity jane has an account. Or if you'd want to do it all in one
-- go, then use a sub query:
select distinct bankname 
from hasaccounts 
where robberid = 
(select robberid 
from robbers 
where nickname = 'Calamity Jane');

--       bankname       
-- ----------------------
--  Bad Bank            
--  Dollar Grabbers     
--  PickPocket Bank  