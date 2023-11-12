select ProductID, ProductName, CategoryName, UnitPrice  
	from Products join Categories On Products.CategoryID = Categories.CategoryID 
	Order by CategoryName DESC, UnitPrice ASC