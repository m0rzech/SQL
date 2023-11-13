select Customers.CompanyName, Orders.OrderDate
from Customers 
left join Orders on Customers.CustomerID = Orders.CustomerID