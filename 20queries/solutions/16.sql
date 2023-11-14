Delete from orderdetails
where orderdetails.OrderID in (
	select o.OrderID from Orders o
	where (o.OrderDate = '1997-02-12')
	   or (o.OrderDate = '1997-02-10')
)