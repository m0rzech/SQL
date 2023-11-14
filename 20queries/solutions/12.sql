select Customers.CustomerID, Products.ProductName, 
sum(orderdetails.Quantity*Products.Price)

from Customers 
 join Orders on  Orders.CustomerID = Customers.CustomerID
 join orderdetails on Orders.OrderID = orderdetails.OrderID
 join Products on orderdetails.ProductID = Products.ProductID

group by Customers.CustomerID, Products.ProductName
order by CustomerID ASC