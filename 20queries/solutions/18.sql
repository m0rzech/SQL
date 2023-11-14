update Products set Price = Price + 2
where SupplierID in (select s.SupplierID 
		     from Suppliers s 
		     where s.Country = 'USA')