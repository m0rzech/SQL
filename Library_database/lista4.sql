--drop table bibliotekarz, wypozyczenie,zaginione,zamowienia,[Kolejka do zamowienia],ksiazka, czytelnik

create table ksiazka(
nr int identity(1,1) Primary Key,
tytul varchar(20),
autor varchar(40),
dzial varchar(10),
gatunek varchar(20),
[rok wydania] int,
wydawnictwo varchar(20)
)

create table bibliotekarz(
nr int identity(1,1) Primary Key,
imie varchar(20),
nazwisko varchar(20),
)

create table czytelnik(
nr int identity(1,1) Primary Key,
imie varchar(20),
nazwisko varchar(20),
[ilosc ksiazek wypozyczonych] int,
[ilosc zagubionych] int,
[data przyjecia] date,
[data urodzenia] date,
kara money
)

create table wypozyczenie(
nr int identity(1,1) Primary Key,
[nr czytelnika] int references czytelnik(nr) on update cascade,
[nr ksiazki] int references ksiazka(nr) on delete cascade,
[data wypozyczenia] date,
[data zwrotu] date,
przedluzenie bit,
[kara za przetrzymanie] money
)

create table [Kolejka do zamowienia](
nr int identity(1,1) Primary Key,
[nr ksiazki] int references ksiazka(nr) on delete cascade,
[nr czytelnika] int references czytelnik(nr) on delete cascade,
[miejsce w kolejce] int,
trwanie date
)

create table zaginione(
[nr ksiazki] int references ksiazka(nr) on delete cascade,
[ostatni czytelnik] int references czytelnik(nr) on delete cascade,
przetrzymanie int
)

create procedure usun_ksiazke_z_bazy
as
declare @zagubiona int
declare @zgubil int
set @zagubiona = (select [nr ksiazki] from wypozyczenie where (YEAR([data zwrotu]) - YEAR(GETDATE())>2))
set @zgubil = (select [nr czytelnika] from wypozyczenie where (YEAR([data zwrotu]) - YEAR(GETDATE())>2))
	
	delete from ksiazka where nr = @zagubiona
	update czytelnik set [ilosc zagubionych] = ([ilosc zagubionych]+1), kara = kara + 50.00
	where czytelnik.nr = @zgubil	

create procedure nalicz_kare(@nr_czytelnika int) as
declare @lmies int
set @lmies = (select Month(([data zwrotu]-GETDATE())) from wypozyczenie)
update czytelnik set kara = kara * @lmies where nr = @nr_czytelnika

create procedure zrezygnuj_z_zamowienia(@nr_czytelnika int, @nr_ksiazki int) as
declare @nr int
set @nr = (select nr from [Kolejka do zamowienia] where @nr_czytelnika = [nr czytelnika] and [nr ksiazki] = @nr_ksiazki)
delete from [Kolejka do zamowienia] where @nr_czytelnika = [nr czytelnika] and @nr_ksiazki = [nr ksiazki]
update [Kolejka do zamowienia] set [miejsce w kolejce] = [miejsce w kolejce]-1 where nr>@nr

create procedure usun_po_terminie(@nr_ksiazki int) as
delete from [Kolejka do zamowienia] where trwanie < GETDATE()

create procedure sprawdz_miejsce(@nr_czytelnika int) as
select [nr czytelnika], tytul, [miejsce w kolejce] from [Kolejka do zamowienia] join ksiazka on [nr ksiazki] = ksiazka.nr where [nr czytelnika] = @nr_czytelnika

create procedure przedluz(@nr_czytelnika int, @nr_ksiazki int) as
update wypozyczenie set [data zwrotu] = DATEADD(MONTH,0,GETDATE()) where [nr czytelnika] = @nr_czytelnika and [nr ksiazki] = @nr_ksiazki

create procedure dodaj_czytelnika(@imie varchar, @nazwisko varchar, @data date) as
declare @dataprzy date
set @dataprzy = GETDATE()
insert into czytelnik values(@imie, @nazwisko, 0, @dataprzy, @data, 0, 0 );

create procedure dodaj_zamownienie(@nr_czytelnika int, @nr_ksiazki int, @trwanie date) as
declare @miejsce int
set @miejsce = (select COUNT([nr ksiazki]) from [Kolejka do zamowienia] where @nr_ksiazki = [nr ksiazki])
insert into [Kolejka do zamowienia] values (@nr_czytelnika, @nr_czytelnika, @miejsce, @trwanie)