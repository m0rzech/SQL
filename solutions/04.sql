select Region, Count(SupplierID) as Ilosc 
from Suppliers group by Region