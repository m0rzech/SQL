select ProductID, ProductName, CategoryName, Price  
	from Products join Categories On Products.CategoryID = Categories.CategoryID 
	Order by CategoryName DESC, Price ASC