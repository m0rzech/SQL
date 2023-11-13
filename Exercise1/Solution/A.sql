--delete from rok2004 where miesiac>-1

/*
SET NOCOUNT ON
GO

declare @a int
set @a = 1

while @a < 30
begin
Insert into rok2004(miesiac,wynik) values ((@a%12+1), RAND()*10000)
set @a = @a+1
end
*/

-- drop function GetNameTable

create function GetNameTable ()
RETURNS @zad1 table(miesiac int, rok int, wynik int)
as
begin
	declare @wynik int
	declare @wynik2004 int
	declare @wynik2005 int
	declare @rok int
	declare @mies int
	set @mies = 1
	
	while @mies<13
	begin		
		select @wynik2004 = MAX(wynik) from rok2004 where miesiac = @mies
		select @wynik2005 = MAX(wynik) from rok2005 where miesiac = @mies
		
		if @wynik2004>@wynik2005
		   begin
			set @wynik = @wynik2004
			set @rok = 2004
		   end
		else 
		   begin
			set @wynik = @wynik2005 
			set @rok = 2005
		   end	
		   
		INSERT INTO @zad1 values (@mies, @rok, @wynik)
		set @mies = @mies + 1
	end

return
end
 

--select * from GetNameTable ()