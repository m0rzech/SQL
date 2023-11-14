select ProductID, Quantity
from orderdetails
group by ProductID
order by Quantity ASC Limit 6