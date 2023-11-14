SELECT a.City, b.City
From suppliers as a, suppliers as b 
Where a.Country = b.Country AND a.City <> b.City;