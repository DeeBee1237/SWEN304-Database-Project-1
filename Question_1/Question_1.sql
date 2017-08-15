CREATE TABLE Banks (
BankName Char (20) NOT NULL,
City Char (20) NOT NULL,
NoAccounts Integer,
Security Char (20),
PRIMARY KEY (BankName,City),
CONSTRAINT accounts_positive CHECK (NoAccounts > 0)
);

CREATE TABLE Robberies (
BankName Char(20) NOT NULL, 
City Char (20) NOT NULL,
DateRobbed Char(20),
Amount Decimal,
PRIMARY KEY (BankName,City,DateRobbed),
FOREIGN KEY (BankName,City) REFERENCES Banks(BankName,City) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT stole_something CHECK (Amount > 0)
);

CREATE TABLE Plans (
BankName Char(20) NOT NULL,
City Char(20) NOT NULL,
PlannedDate Char (20),
NoRobbers Integer,
PRIMARY KEY (BankName,City,PlannedDate,NoRobbers),
FOREIGN KEY (BankName,City) REFERENCES Banks (BankName,City) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT robbers_exist CHECK (NoRobbers > 0)
);

CREATE TABLE Robbers (
RobberId SERIAL PRIMARY KEY,
NickName Char(20),
Age Integer CHECK (Age > 0), -- maybe make this 18 or something later ?
NoYears Integer CHECK (NoYears >= 0), -- can't do negative time
CONSTRAINT prison_age CHECK (NoYears < Age)
);

CREATE TABLE Skills (
SkillId SERIAL PRIMARY KEY,
Description Char (20)
);

CREATE TABLE HasSkills (
RobberId Integer,
SkillId Integer,
Preference Integer,
Grade Char(20),
PRIMARY KEY (RobberId,SkillId),
FOREIGN KEY (RobberId) REFERENCES Robbers(RobberId) ON DELETE CASCADE ON UPDATE RESTRICT,
FOREIGN KEY (SkillId) REFERENCES Skills(SkillId) ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE HasAccounts (
RobberId Integer,
BankName Char(20) NOT NULL,
City Char(20) NOT NULL,
PRIMARY KEY (RobberId,BankName,City),
FOREIGN KEY (RobberId) REFERENCES Robbers(RobberId) ON DELETE CASCADE ON UPDATE RESTRICT,
FOREIGN KEY (BankName,City) REFERENCES Banks(BankName,City) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Accomplices (
RobberId Integer,
BankName Char(20) NOT NULL,
City Char(20) NOT NULL,
RobberyDate Char(20),
Share Integer,
PRIMARY KEY (RobberId,BankName,City,RobberyDate),
FOREIGN KEY (RobberId) REFERENCES Robbers(RobberId) ON DELETE CASCADE ON UPDATE RESTRICT,
FOREIGN KEY (BankName,City,RobberyDate) REFERENCES Robberies(BankName,City,DateRobbed) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT share_not_negative CHECK (Share > 0)
);