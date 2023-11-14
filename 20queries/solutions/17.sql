insert into orderdetails
select 600,o.OrderID, 11, 12
from Orders o where o.OrderDate >= '1997-01-29 00:00' and o.OrderDate < '1997-01-30 00:00' Limit 1 