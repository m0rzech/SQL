--drop table Koncert, Klub, Zespol
SET NOCOUNT ON
GO

create table Klub(
					nazwa nvarchar(30) Primary key, 
					adres nvarchar(30))
					
create table Zespol(
					nazwa nvarchar(30) Primary key, 
					[ilosc czlonkow] int)
					
create table Koncert(
                      [nazwa klubu] nvarchar(30) references Klub(nazwa) ON update cascade,  
                      [nazwa zespolu] nvarchar(30) references Zespol(nazwa) ON update cascade,
                      data date)
                      
insert into Klub values ('DKFJLD', 'sfkdjflksjflkds');
insert into Klub values ('FGFGFG', 'gffdgfdgfd');
insert into Klub values ('DKFFGDGFDJLD', 'dfgf');
insert into Klub values ('GFG', 'dfgdr');
insert into Klub values ('DFSSFDS', 'erte345rfg');
insert into Klub values ('FG', 'bvcytrbv');
insert into Klub values ('JHJUYY', '45tfdtregr');
insert into Klub values ('EWREWRWE', 'dfgretf');

insert into Zespol values ('sdfds', 45);
insert into Zespol values ('dfs', 54);
insert into Zespol values ('gfgfg', 3);
insert into Zespol values ('sdfdffds', 57);
insert into Zespol values ('dsdsdy', 12);
insert into Zespol values ('565t5', 3);
insert into Zespol values ('564gr65', 76);
insert into Zespol values ('4tfr54', 1);
insert into Zespol values ('45f45frf', 43);
insert into Zespol values ('56465vt', 33);
insert into Zespol values ('alamakota', 11);

insert into Koncert values ('EWREWRWE', 'dsdsdy', '2010-01-01')
insert into Koncert values ('FGFGFG', '45f45frf', '2010-04-01')
insert into Koncert values ('FGFGFG', 'alamakota', '2011-01-01')
insert into Koncert values ('DKFFGDGFDJLD', 'alamakota', '1999-08-23')
insert into Koncert values ('EWREWRWE', 'alamakota', '2015-02-21')
insert into Koncert values ('GFG', 'dsdsdy', '2034-01-01')
insert into Koncert values ('DKFFGDGFDJLD', '45f45frf', '2066-01-01')

