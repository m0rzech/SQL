update Products set UnitPrice = UnitPrice + 2
where SupplierID in (select s.SupplierID 
		     from Suppliers s 
		     where s.Country = 'USA')