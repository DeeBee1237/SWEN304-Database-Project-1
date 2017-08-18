------------------------
-- step wise approach --
------------------------

-- which robbers robbed banks of certain security levels:
CREATE VIEW robbersAndSecurityLevel as (
SELECT DISTINCT a.robberid as robber_id,
b.security as security_level
FROM Banks b 
JOIN Accomplices a 
ON b.bankname = a.bankname 
AND b.city = a.city
ORDER BY security_level);

-- now this view will display the robberid and skill id next to the security level:
CREATE VIEW securityLevelAndSkills as (
SELECT h.robberid as robberid,
h.skillid as skillid,
r_a_s.security_level as security_level
FROM hasSkills h
Join robbersAndSecurityLevel r_a_s
ON h.robberid = r_a_s.robber_id);

-- now join with the skills table to obtain the skill description instead of the 
-- skill id:
CREATE VIEW withSkillDescriptions as (
SELECT sls.security_level as security_level, 
sls.robberid as robberid,
s.description as skill_description
FROM securityLevelAndSkills sls
JOIN skills s
ON sls.skillid = s.skillid);

CREATE VIEW finalResult as (
SELECT w.security_level as security_level,
w.skill_description as skill_description,
r.nickname as nickname
FROM Robbers r 
JOIN withSkillDescriptions w
ON r.robberid = w.robberid);

select * from finalResult;

----------------------
-- The single query --
----------------------
SELECT w.security_level as security_level,
w.skill_description as skill_description,
r.nickname as nickname
FROM Robbers r 
JOIN (SELECT sls.security_level as security_level, 
sls.robberid as robberid,
s.description as skill_description
FROM (SELECT h.robberid as robberid,
h.skillid as skillid,
r_a_s.security_level as security_level
FROM hasSkills h
Join (SELECT DISTINCT a.robberid as robber_id,
b.security as security_level
FROM Banks b 
JOIN Accomplices a 
ON b.bankname = a.bankname
AND b.city = a.city
ORDER BY security_level) r_a_s
ON h.robberid = r_a_s.robber_id) sls
JOIN skills s
ON sls.skillid = s.skillid) w
ON r.robberid = w.robberid;

--    security_level    |  skill_description   |       nickname       
-- ----------------------+----------------------+----------------------
--  excellent            | Driving              | Lucky Luchiano      
--  excellent            | Lock-Picking         | Lucky Luchiano      
--  excellent            | Guarding             | Lucky Luchiano      
--  excellent            | Guarding             | Anastazia           
--  excellent            | Driving              | Mimmy The Mau Mau   
--  excellent            | Planning             | Mimmy The Mau Mau   
--  excellent            | Driving              | Dutch Schulz        
--  excellent            | Lock-Picking         | Dutch Schulz        
--  excellent            | Scouting             | Clyde               
--  excellent            | Lock-Picking         | Clyde               
--  excellent            | Planning             | Clyde               
--  excellent            | Preaching            | Bonnie              
--  excellent            | Safe-Cracking        | Meyer Lansky        
--  excellent            | Planning             | Boo Boo Hoff        
--  excellent            | Planning             | King Solomon        
--  excellent            | Guarding             | Bugsy Siegel        
--  excellent            | Driving              | Bugsy Siegel        
--  excellent            | Driving              | Longy Zwillman      
--  excellent            | Gun-Shooting         | Waxey Gordon        
--  excellent            | Preaching            | Greasy Guzik        
--  excellent            | Lock-Picking         | Greasy Guzik        
--  excellent            | Safe-Cracking        | Sonny Genovese      
--  excellent            | Explosives           | Sonny Genovese      
--  excellent            | Lock-Picking         | Sonny Genovese      
--  good                 | Money Counting       | Mickey Cohen        
--  good                 | Money Counting       | Kid Cann            
--  good                 | Cooking              | Vito Genovese       
--  good                 | Scouting             | Vito Genovese       
--  good                 | Eating               | Vito Genovese       
--  very good            | Explosives           | Bugsy Malone        
--  very good            | Guarding             | Anastazia           
--  very good            | Safe-Cracking        | Moe Dalitz          
--  very good            | Planning             | King Solomon        
--  very good            | Driving              | Longy Zwillman      
--  very good            | Guarding             | Lepke Buchalter     
--  very good            | Driving              | Lepke Buchalter     
--  very good            | Safe-Cracking        | Sonny Genovese      
--  very good            | Explosives           | Sonny Genovese      
--  very good            | Lock-Picking         | Sonny Genovese      
--  weak                 | Driving              | Dutch Schulz        
--  weak                 | Lock-Picking         | Dutch Schulz        
--  weak                 | Scouting             | Clyde               
--  weak                 | Lock-Picking         | Clyde               
--  weak                 | Planning             | Clyde               
--  weak                 | Planning             | Boo Boo Hoff        
--  weak                 | Guarding             | Bugsy Siegel        
--  weak                 | Driving              | Bugsy Siegel        
--  weak                 | Cooking              | Vito Genovese       
--  weak                 | Scouting             | Vito Genovese       
--  weak                 | Eating               | Vito Genovese       
--  weak                 | Preaching            | Greasy Guzik        
--  weak                 | Lock-Picking         | Greasy Guzik        
--  weak                 | Guarding             | Lepke Buchalter     
--  weak                 | Driving              | Lepke Buchalter     
--  weak                 | Safe-Cracking        | Sonny Genovese      
--  weak                 | Explosives           | Sonny Genovese      
--  weak                 | Lock-Picking         | Sonny Genovese      
-- (57 rows)
