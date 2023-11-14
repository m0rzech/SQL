select Customers.CustomerName, Orders.OrderDate
from Customers 
left join Orders on Customers.CustomerID = Orders.CustomerID