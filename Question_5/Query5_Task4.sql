------------------------
-- step wise approach --
------------------------

-- a view that displays the plans table with a single year value for the date
CREATE VIEW plansWithOnlyYear as (
select extract (year from to_date(planneddate,'YYYY')) as yyyy,
bankname,
city
from plans
);

CREATE VIEW oneYearFromNow as (
select date_part('year',current_date + interval '1 year')
);

-- all the banks that are planned to be robbed one year from now:
CREATE VIEW banksPlannedToBeRobbedNextYear as (
select bankname,city 
from (select * from plansWithOnlyYear) as plansWithOnlyYear
where yyyy = (select * from oneYearFromNow)
);

-- the robberies table, but only the year for the date value
CREATE VIEW robberiesWithOnlyYear as (
select extract (year from to_date(daterobbed,'YYYY')) as yyyy,bankname,city from robberies
);

-- displays the previous year:
CREATE VIEW lastYear as (
select date_part('year',current_date - interval '1 year')
);

CREATE VIEW banksRobbedLastYear as (
select bankname,city
from (select * from robberiesWithOnlyYear) as robberiesWithOnlyYear 
where yyyy = (select * from lastYear)
);

-- The banks that were not robbed last year:
CREATE VIEW banksNotRobbedLastYear as (
select bankname,
city
from robberies
where (bankname,city) NOT IN (select * from banksRobbedLastYear)
);

-- all banks (bankname,city) that were not robbed last year but will be robbed next year
CREATE VIEW banksNotRobbedButWillBe as (
SELECT 
nr.bankname as bankname,
nr.city as city
FROM banksNotRobbedLastYear nr 
JOIN banksPlannedToBeRobbedNextYear pr
ON nr.bankname = pr.bankname 
AND nr.city = pr.city
);

-- the same view as above, only now the final result also displays the security level of those banks:
CREATE VIEW withSecurityLevelToo as (
SELECT b.bankname as bankname,
b.city as city,
b.security as security_level
FROM Banks b 
JOIN banksNotRobbedButWillBe bnr
ON b.bankname = bnr.bankname
AND b.city = bnr.city
ORDER BY noaccounts);

select * from withSecurityLevelToo;

----------------------
-- The single query --
----------------------

SELECT b.bankname as bankname,
b.city as city,
b.security as security_level
FROM Banks b 
JOIN (SELECT 
nr.bankname as bankname,
nr.city as city
FROM (select bankname,
city
from robberies
where (bankname,city) NOT IN (
select bankname,city
from (select extract (year from to_date(daterobbed,'YYYY')) as yyyy,bankname,city from robberies) as all_years 
where yyyy = (select date_part('year',current_date - interval '1 year')))) as nr 
JOIN (select bankname,city 
from (select extract (year from to_date(planneddate,'YYYY')) as yyyy,bankname,city from plans) as all_years 
where yyyy = (select date_part('year',current_date + interval '1 year'))) as pr
ON nr.bankname = pr.bankname 
AND nr.city = pr.city) bnr
ON b.bankname = bnr.bankname
AND b.city = bnr.city
ORDER BY noaccounts;


--        bankname       |         city         |    security_level    
-- ----------------------+----------------------+----------------------
--  Bad Bank             | Chicago              | weak                
-- (1 row)


