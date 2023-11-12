insert into [Order Details] 
select top 1 
	o.OrderID, 1, 15, 1, 0 
from Orders o where o.OrderDate >= '1998-04-14 00:00' and o.OrderDate < '1998-04-15 00:00'