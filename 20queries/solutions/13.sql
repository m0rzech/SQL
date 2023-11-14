select ProductID, MIN(Quantity)
from orderdetails
group by ProductID