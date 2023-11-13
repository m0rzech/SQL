-- drop table lista
-- drop procedure zad2

/*
CREATE TABLE lista (tabela varchar(40), kolumna varchar(30), ileznull int, ilebeznull int)
INSERT INTO lista values ('random_data', 'GUIDcol',null, null)
INSERT INTO lista values ('rok2004', 'miesiac',null, null)
INSERT INTO lista values ('rok2004', 'wynik',null, null)
INSERT INTO lista values ('rok2005', 'miesiac',null, null)
INSERT INTO lista values ('rok2005', 'wynik',null, null)
*/

Create procedure zad2 as
	SET NOCOUNT ON
	GO 
	
	declare @nazwaTab varchar(30)
	declare @nazwaKol varchar(30)
	declare @wart int
	declare @wart2 int
	declare @zapytanie nvarchar(1000)
	declare kursor cursor for
		select tabela, kolumna from lista
	open kursor
	fetch next from kursor into @nazwaTab, @nazwaKol
	
	while @@FETCH_STATUS = 0
		begin
		  select @nazwaTab, @nazwaKol
		  set @zapytanie = ' select @wart = COUNT('+@nazwaKol+') from '+@nazwaTab+' where '+@nazwaKol+' is not null'
		  exec sp_executesql @zapytanie, N'@wart int output',@wart output
		  set @zapytanie = ' select @wart2 = COUNT(*) from '+@nazwaTab+' where '+@nazwaKol+' is null' 
		  exec sp_executesql @zapytanie, N'@wart2 int output',@wart2 output
		  SET @wart2 = @wart+@wart2;
		  update lista set ilebeznull = @wart, ileznull = @wart2 where current of kursor
		  fetch next from kursor into @nazwaTab, @nazwaKol
		end
	close kursor
	deallocate kursor
go

exec zad2 