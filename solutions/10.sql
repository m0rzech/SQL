select Products.ProductName, Orders.OrderDate
from Products
join [Order Details] on [Order Details].ProductID = Products.ProductID
join Orders on Orders.OrderID = [Order Details].OrderID