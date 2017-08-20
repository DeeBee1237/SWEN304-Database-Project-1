select city, avg(share) as average_share
from accomplices
where city = 'Chicago'
group by city
union all
(select city, avg(share) as average_share
from accomplices
where city <> 'Chicago'
group by city order by average_share desc
LIMIT 1);

--          city         |     average_share     
-- ----------------------+-----------------------
--  Chicago              | 4178.0909090909090909
--  Evanston             | 8232.1666666666666667