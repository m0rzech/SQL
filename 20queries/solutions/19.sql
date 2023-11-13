--alter table Products add TotalSales int null;

update Products set TotalSales = (
									select SUM(od.Quantity) 
									from [Order Details] as od
									where od.ProductID = Products.ProductID
								);