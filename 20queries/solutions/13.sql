select ProductID, MIN(Quantity)
from [Order Details]
group by ProductID