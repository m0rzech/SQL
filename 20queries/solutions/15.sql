#--drop table Temp ;

Create Temporary Table Temp
select * from Customers
where CustomerName like 't%';

select * from Temp;