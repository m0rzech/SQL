alter table Products add TotalSales int null;

update Products set TotalSales = (
									select SUM(od.Quantity) 
									from orderdetails as od
									where od.ProductID = Products.ProductID
								);