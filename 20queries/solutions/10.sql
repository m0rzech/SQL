select Products.ProductName, Orders.OrderDate
from Products
join orderdetails on orderdetails.ProductID = Products.ProductID
join Orders on Orders.OrderID = orderdetails.OrderID