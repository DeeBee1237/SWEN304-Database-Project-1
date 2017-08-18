---------------
--*** Q1 ***---
---------------

INSERT INTO Banks (BankName,City,NoAccounts,Security)
Values ('Loanshark Bank','Evanston',100,'very good');

-- ERROR:  duplicate key value violates unique constraint "banks_pkey"
-- DETAIL:  Key (bankname, city)=(Loanshark Bank      , Evanston            ) already exists.

-- This insertion would violate the uniqueness constraint of the primary key; there is already a 
-- bank in the banks table with (bankname, city)=(Loanshark Bank,Evanston), hence the error message

INSERT INTO Banks (BankName,City,NoAccounts,Security)
Values ('EasyLoan Bank','Evanston',-5,'excellent');

-- ERROR:  new row for relation "banks" violates check constraint "accounts_positive"
-- DETAIL:  Failing row contains (EasyLoan Bank       , Evanston            , -5, excellent           ).

-- This is because there is a check constraint in the Banks table which checks that the Number
-- of accounts is positive. In this row, NoAccounts = -5 which is < 0, hence the error message

INSERT INTO Banks (BankName,City,NoAccounts,Security)
Values ('EasyLoan Bank','Evanston',100,'poor');

-- INSERT 0 1

---------------
--*** Q2 ***---
---------------

INSERT INTO Skills VALUES (20,'Guarding');
-- INSERT 0 1

---------------
--*** Q3 ***---
---------------

INSERT INTO Robbers VALUES (1,'Shotgun',70,0);

-- ERROR:  duplicate key value violates unique constraint "robbers_pkey"
-- DETAIL:  Key (robberid)=(1) already exists.

-- There is already a row in robbers with a robberid value of 1, therefore this 
-- insertion would violate the uniqueness constraint of the primary key, hence the error message

INSERT INTO Robbers VALUES (333,'Jail Mouse', 25, 35);

-- ERROR:  new row for relation "robbers" violates check constraint "prison_age"
-- DETAIL:  Failing row contains (333, Jail Mouse          , 25, 35).

-- This is because there is a check in the Robbers table that checks a robber didn't spend more
-- time in jail than they were alive. In this case, the robbers age is 25 but spent 35 years in prison 
-- this makes no sense, violates the constraint and hence the error message shows.

---------------
--*** Q4 ***---
---------------

INSERT INTO HasSkills VALUES (333, 1, 1, 'B-');

-- ERROR:  insert or update on table "hasskills" violates foreign key constraint "hasskills_robberid_fkey"
-- DETAIL:  Key (robberid)=(333) is not present in table "robbers".

-- This is because all robber id values in hasskills must be a subset of all robber id values in robbers.
-- This is a foreign key constraint, and in this case inserting a tuple with id = 333 would violate this constraint
-- because there is no id value of 333 in the robbers table. Hence the error message

INSERT INTO HasSkills VALUES (3, 20, 3, 'B+');
-- INSERT 0 1

INSERT INTO HasSkills VALUES (1, 7, 1, 'A+');
-- INSERT 0 1

INSERT INTO HasSkills VALUES (1, 2, 0, 'A');
-- INSERT 0 1

---------------
--*** Q5 ***---
---------------

INSERT INTO Robberies VALUES ('NXP Bank','Chicago','2009-01-08',1000);

-- ERROR:  duplicate key value violates unique constraint "robberies_pkey"
-- DETAIL:  Key (bankname, city, daterobbed)=(NXP Bank            , Chicago             , 2009-01-08

-- This violates the uniqueness constraint of the primary key in Robberies (bankname, city, daterobbed)
-- a tuple with these (bankname, city, daterobbed) values already exists in the robberies table

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

-- This would violate the foreign key constraint, because accomplices references this specific bank record
-- and the ON DELETE RESTRICT prevents this record from being removed from banks.

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