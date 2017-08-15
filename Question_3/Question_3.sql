---------------
--*** Q1 ***---
---------------

INSERT INTO Banks (BankName,City,NoAccounts,Security)
Values ('Loanshark Bank','Evanston',100,'very good');

-- ERROR:  duplicate key value violates unique constraint "banks_pkey"
-- DETAIL:  Key (bankname, city)=(Loanshark Bank      , Evanston            ) already exists.

INSERT INTO Banks (BankName,City,NoAccounts,Security)
Values ('EasyLoan Bank','Evanston',-5,'excellent');

-- ERROR:  new row for relation "banks" violates check constraint "accounts_positive"
-- DETAIL:  Failing row contains (EasyLoan Bank       , Evanston            , -5, excellent           ).

INSERT INTO Banks (BankName,City,NoAccounts,Security)
Values ('EasyLoan Bank','Evanston',100,'poor');

-- No constraint Violation/Error

---------------
--*** Q2 ***---
---------------

INSERT INTO Skills VALUES (20,'Guarding');
-- No constraint Violation/Error

---------------
--*** Q3 ***---
---------------

INSERT INTO Robbers VALUES (1,'Shotgun',70,0);

-- ERROR:  duplicate key value violates unique constraint "robbers_pkey"
-- DETAIL:  Key (robberid)=(1) already exists.

INSERT INTO Robbers VALUES (333,'Jail Mouse', 25, 35);

-- ERROR:  new row for relation "robbers" violates check constraint "prison_age"
-- DETAIL:  Failing row contains (333, Jail Mouse          , 25, 35).

---------------
--*** Q4 ***---
---------------

INSERT INTO HasSkills VALUES (333, 1, 1, 'B-');

-- ERROR:  insert or update on table "hasskills" violates foreign key constraint "hasskills_robberid_fkey"
-- DETAIL:  Key (robberid)=(333) is not present in table "robbers".

INSERT INTO HasSkills VALUES (3, 20, 3, 'B+');
-- No Violation/Error

INSERT INTO HasSkills VALUES (1, 7, 1, 'A+');
-- No Violation/Error

INSERT INTO HasSkills VALUES (1, 2, 0, 'A');
-- No Violation/Error

---------------
--*** Q5 ***---
---------------

INSERT INTO Robberies VALUES ('NXP Bank','Chicago','2009-01-08',1000);

-- ERROR:  duplicate key value violates unique constraint "robberies_pkey"
-- DETAIL:  Key (bankname, city, daterobbed)=(NXP Bank            , Chicago             , 2009-01-08

---------------
--*** Q6 ***---
---------------

DELETE FROM Banks 
WHERE BankName = 'PickPocket Bank'
AND City = 'Evanston'
AND NoAccounts = 2000
AND Security = 'very good';

-- ERROR:  update or delete on table "robberies" violates foreign key constraint "accomplices_bankname_fkey" on table "accomplices"
-- DETAIL:  Key (bankname, city, daterobbed)=(PickPocket Bank     , Evanston            , 2006-01-30          ) is still referenced from table "accomplices".

DELETE FROM Banks 
WHERE BankName = 'Outside Bank'
AND City = 'Chicago'
AND NoAccounts = 5000
AND Security = 'good';

-- DELETE 1
-- No Error/Violation.

---------------
--*** Q7 ***---
---------------

DELETE FROM Robbers
WHERE RobberId = 1
AND NickName = 'Al Capone'
AND Age = 31 
AND NoYears = 2;

-- DELETE 1
-- No Error/Violation

---------------
--*** Q8 ***---
---------------

DELETE FROM Skills
WHERE SkillId = 1
AND Description = 'Driving';

-- DELETE 0, meaning no such tuple exists