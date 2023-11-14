select ProductID
from orderdetails
group by ProductID
having AVG(Quantity) > 2