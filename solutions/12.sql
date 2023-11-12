select Customers.CustomerID, Products.ProductName, 
sum([Order Details].Quantity*[Order Details].UnitPrice)

from Customers 
 join Orders on  Orders.CustomerID = Customers.CustomerID
 join [Order Details] on Orders.OrderID = [Order Details].OrderID
 join Products on [Order Details].ProductID = Products.ProductID

group by Customers.CustomerID, Products.ProductName
order by CustomerID ASC