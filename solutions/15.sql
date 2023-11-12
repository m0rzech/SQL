--drop table [#Temp] ;

select * INTO #Temp from Customers
where CompanyName like 't%';

select * from #Temp;