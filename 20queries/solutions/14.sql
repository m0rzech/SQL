select *
from Customers c
where c.CustomerID in (
	select o.CustomerID from Orders o
	where o.OrderDate < '1996-07-04 00:00' or o.OrderDate >= '1996-07-05 00:00'
)