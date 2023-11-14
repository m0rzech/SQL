use Northwind
select Shippers.ShipperName, Suppliers.SupplierName
from Shippers, Suppliers
where Shippers.ShipperName like 's%' and Suppliers.SupplierName like 's%'