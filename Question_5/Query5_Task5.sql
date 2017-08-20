select city,
avg(share) as average_share
from accomplices
group by city;

--          city         |     average_share     
-- ----------------------+-----------------------
--  Evanston             | 8232.1666666666666667
--  Chicago              | 4178.0909090909090909