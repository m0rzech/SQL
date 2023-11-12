select Employees.LastName, Orders.OrderID
from Orders 
join Employees on Orders.EmployeeID = Employees.EmployeeID
where orders.OrderDate < '1998-01-23'