select ProductName, CategoryName 
from Categories inner join Products on Categories.CategoryID = Products.ProductID 
where ProductName like '%p' and CategoryName like 'C%'
