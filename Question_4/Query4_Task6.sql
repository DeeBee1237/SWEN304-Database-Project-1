-- Alternative single nested query:
-- SELECT s.description as description,
-- r.robberid as robberid,
-- r.nickname as nickname
-- FROM (select s.description as description,
-- h.robberid as robber_id
-- FROM hasskills h 
-- JOIN skills s 
-- ON h.skillid = s.skillid
-- ORDER BY description) as s 
-- JOIN Robbers r
-- ON r.robberid = s.robber_id;

DROP VIEW IF EXISTS SkillsAndRobbers CASCADE;

-- a view showing all the skill descriptions in their own chunks
-- allong with which robbers posses each of the skills:
CREATE VIEW SkillsAndRobbers as (
select s.description as description,
h.robberid as robber_id
FROM hasskills h 
JOIN skills s 
ON h.skillid = s.skillid
ORDER BY description);

-- now join the skills and robbers view with the robbers table
-- to obtain the required data:
SELECT s.description as description,
r.robberid as robberid,
r.nickname as nickname
FROM SkillsAndRobbers s 
JOIN Robbers r
ON r.robberid = s.robber_id;

--      description      | robberid |       nickname       
-- ----------------------+----------+----------------------
--  Cooking              |       18 | Vito Genovese       
--  Driving              |       23 | Lepke Buchalter     
--  Driving              |        7 | Dutch Schulz        
--  Driving              |        5 | Mimmy The Mau Mau   
--  Driving              |       20 | Longy Zwillman      
--  Driving              |       17 | Bugsy Siegel        
--  Driving              |        3 | Lucky Luchiano      
--  Eating               |       18 | Vito Genovese       
--  Eating               |        6 | Tony Genovese       
--  Explosives           |       24 | Sonny Genovese      
--  Explosives           |        2 | Bugsy Malone        
--  Guarding             |        3 | Lucky Luchiano      
--  Guarding             |        4 | Anastazia           
--  Guarding             |       17 | Bugsy Siegel        
--  Guarding             |       23 | Lepke Buchalter     
--  Gun-Shooting         |        9 | Calamity Jane       
--  Gun-Shooting         |       21 | Waxey Gordon        
--  Lock-Picking         |        7 | Dutch Schulz        
--  Lock-Picking         |        8 | Clyde               
--  Lock-Picking         |       24 | Sonny Genovese      
--  Lock-Picking         |       22 | Greasy Guzik        
--  Lock-Picking         |        3 | Lucky Luchiano      
--  Money Counting       |       13 | Mickey Cohen        
--  Money Counting       |       19 | Mike Genovese       
--  Money Counting       |       14 | Kid Cann            
--  Planning             |        5 | Mimmy The Mau Mau   
--  Planning             |        8 | Clyde               
--  Planning             |       15 | Boo Boo Hoff        
--  Planning             |       16 | King Solomon        
--  Preaching            |       10 | Bonnie              
--  Preaching            |       22 | Greasy Guzik        
--  Safe-Cracking        |       11 | Meyer Lansky        
--  Safe-Cracking        |       24 | Sonny Genovese      
--  Safe-Cracking        |       12 | Moe Dalitz          
--  Scouting             |       18 | Vito Genovese       
--  Scouting             |        8 | Clyde               
-- (36 rows)
