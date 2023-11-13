select ProductID
from [Order Details]
group by ProductID
having AVG(Quantity) > 2
