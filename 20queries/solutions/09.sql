use Northwind
select Shippers.CompanyName, Suppliers.CompanyName
from Shippers, Suppliers
where Shippers.CompanyName like 's%' and Suppliers.CompanyName like 's%'