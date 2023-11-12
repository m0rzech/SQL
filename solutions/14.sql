select *
from Customers c
where c.CustomerID in (
	select o.CustomerID from Orders o
	where o.OrderDate < '1997-05-15 00:00' or o.OrderDate >= '1997-05-16 00:00'
)