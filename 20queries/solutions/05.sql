select top 6 ProductID
from [Order Details] 
group by ProductID
order by SUM(UnitPrice * Quantity) ASC
