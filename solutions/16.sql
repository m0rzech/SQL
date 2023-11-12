delete from [Order Details]
where [Order Details].OrderID in (
	select o.OrderID from Orders o
	where (o.OrderDate = '1998-04-14')
	   or (o.OrderDate = '1999-07-17')
)