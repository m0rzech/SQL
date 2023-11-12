SELECT a.TerritoryDescription, b.TerritoryDescription  
From Territories as a, Territories as b 
Where a.RegionID = b.RegionID AND a.TerritoryID <> b.TerritoryID;