-- Banks,Robberies,Plans and Robbers were table that were easy to populate
-- using the simple SQL COPY Command, since the respective files matched the schemas
-- perfectly, the rest were a little grittier to load.

\copy Banks FROM 'Desktop/banks_17.data';
\copy Robberies FROM 'Desktop/robberies_17.data';
\copy Plans FROM 'Desktop/plans_17.data';
\copy Robbers(NickName,Age,NoYears) FROM 'Desktop/robbers_17.data';

-----------------------------------------------
-- *** For populating the skills table: *** ---
-----------------------------------------------

-- a temporary table storing all the information from the hasskills data file
CREATE TABLE TempHasSkills (
nickname Char (20),
skill Char (20),
pref Integer,
grade Char(3),
PRIMARY KEY (nickname,skill)
);

-- now load the temp table with the data from the file:
\copy TempHasSkills FROM 'Desktop/hasskills_17.data';

-- now populate the Skills table using the Temporary has skills table:
INSERT INTO Skills (Description) SELECT DISTINCT Skill FROM TempHasSkills;

--------------------------------------------------
-- *** For populating the HasSkills table: *** ---
--------------------------------------------------

-- a view which shows all the data from the hasskills data file
-- along with the robber Id next to every robber:
CREATE VIEW nicknameIDSkill as (SELECT r.robberId as RobberID,
t.nickname as nickname,
t.pref as preference,
t.grade as grade,
t.skill as skill 
FROM Robbers r JOIN TempHasSkills t 
ON t.nickname = r.nickname);

-- a view that joins the above view, with the Skills table
-- to generate a view that contains all the data needed for the 
-- hasskills table:
CREATE VIEW skillIDView as (
SELECT n.robberid as RobberID,
s.skillID as skill_ID,
n.preference as preference,
n.grade as grade
FROM Skills s JOIN nicknameIDSkill n 
ON n.skill = s.Description
);

-- finally, insert all the data into the hasskills table:
INSERT INTO HasSKills SELECT * FROM SkillIDView;

----------------------------------------------------
-- *** For populating the HasAccounts table: *** ---
----------------------------------------------------

-- a temporary table that will store all the data from the hasaccounts data file:
CREATE TABLE TempHasAccounts (
RobberName Char (20),
BankName Char (20),
City Char (20),
PRIMARY KEY (RobberName,BankName,City)
);

-- now load the temp table with the data from the file:
\copy TempHasAccounts FROM 'Desktop/hasaccounts_17.data';

-- the view that's created by joining the robbers table with the 
-- temphasaccounts table, to display all the data needed for hasaccounts:
CREATE VIEW idBankNameCity as (
SELECT r.robberId as robber_id,
t_h_a.BankName as bankName,
t_h_a.City as City
FROM TempHasAccounts t_h_a JOIN Robbers r 
ON r.nickname = t_h_a.RobberName
);

-- insert all the data from the above view into hasaccounts:
INSERT INTO HasAccounts SELECT * FROM idBankNameCity;

----------------------------------------------------
-- *** For populating the Accomplices table: *** ---
----------------------------------------------------

-- create a temp table that stores all the data from the accomplices file:
CREATE TABLE TempAccomplices (
RobberName Char(20),
BankName Char(20),
City Char(20),
DateOfRobbery Char(20),
Share DECIMAL,
PRIMARY KEY (RobberName,BankName,City,DateOfRobbery)
);

-- populate the temp table by using the file:
\copy TempAccomplices FROM 'Desktop/accomplices_17.data';

-- now make a join with the robbers table, and obtain the information relevant 
-- to the accomplices table, then insert the relevant data into accomplices:
INSERT INTO Accomplices SELECT r.robberid as robber_id,
ta.bankName as bank_name,
ta.city as city,
ta.DateOfRobbery as date_robbed,
ta.Share as share
FROM Robbers r JOIN TempAccomplices ta 
ON r.nickname = ta.robberName;