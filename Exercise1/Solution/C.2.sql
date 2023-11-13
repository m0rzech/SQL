--drop view Koncerty

---------------------- CREATE VIEW ----------------------------------
create view Koncerty as 
 Select Klub.nazwa as Knazwa, adres, Zespol.nazwa as Znazwa, [ilosc czlonkow] as ilosc, data
 From Klub 
 Inner Join Koncert on Klub.nazwa = Koncert.[nazwa klubu]
 Inner Join Zespol on Zespol.nazwa = Koncert.[nazwa zespolu];
 
 select * from Koncerty

---------------------- INSERT ----------------------------------

 Create trigger tri on Koncerty 
 INSTEAD OF INSERT
 as begin 
  if (EXISTS(Select * from Koncerty, inserted where inserted.Knazwa = Koncerty.Knazwa AND inserted.Znazwa = Koncerty.Znazwa AND inserted.data = Koncerty.data AND inserted.adres = Koncerty.adres AND inserted.ilosc = Koncerty.ilosc)) begin 
       Raiserror('krotka juz istnieje',0,0) return end
    else begin
     if(EXISTS (Select * from Zespol, Klub, inserted where inserted.Knazwa = Klub.nazwa AND inserted.Znazwa = Zespol.nazwa)) begin
      if(NOT EXISTS (Select * from Zespol, Klub, inserted where inserted.adres = Klub.adres AND inserted.ilosc = Zespol.[ilosc czlonkow])) begin
       Raiserror('dane zespolu lub klubu nie zgadzaja sie',0,0) return end
     end
      else begin
       if(EXISTS (Select * from Zespol, inserted where inserted.Znazwa = Zespol.nazwa)) begin
        INSERT INTO Klub Select Knazwa, adres from inserted
       end
       else if (EXISTS (Select * from Klub, inserted where inserted.Knazwa = Klub.nazwa))begin 
        INSERT INTO Klub Select Knazwa, adres from inserted
       end
       else begin 
       INSERT INTO Klub Select Knazwa, adres from inserted
       INSERT INTO Zespol Select Znazwa, ilosc from inserted
       end
      end
    end
	INSERT INTO Koncert select Knazwa, Znazwa, data from inserted      
end

---------------------- UPDATE ----------------------------------
 Create trigger tru on Koncerty
INSTEAD OF UPDATE
as begin
 if UPDATE(Knazwa) begin
  UPDATE Klub 
   SET nazwa = (Select Knazwa from inserted)
   WHERE adres = (Select adres from deleted)
    AND nazwa = (Select Knazwa from deleted)
 end
 
 if UPDATE(adres) begin
  UPDATE Klub
   SET adres = (Select adres from inserted)
   WHERE nazwa = (Select Knazwa from deleted)
    AND adres = (Select adres from deleted)
 end
 
 if UPDATE(Znazwa) begin
  UPDATE Zespol
   SET nazwa = (Select Znazwa from inserted)
   WHERE [ilosc czlonkow] = (Select ilosc from deleted)
    AND nazwa = (Select Znazwa from deleted)
 end
 
 if UPDATE(ilosc) begin
  UPDATE Zespol
   SET [ilosc czlonkow] = (Select ilosc from inserted)
   WHERE nazwa = (Select Znazwa from deleted)
    AND [ilosc czlonkow] = (Select [ilosc czlonkow] from deleted)
 end
 
 if UPDATE(data) begin
  UPDATE Koncert 
   SET data = (Select data from inserted)
   WHERE [nazwa klubu] = (Select [nazwa klubu] from deleted)
    AND [nazwa zespolu] = (Select [nazwa zespolu] from deleted)
    AND data = (Select data from deleted)
 end
 end
---------------- DELETE ----------------------------------------------
create trigger trd on Koncerty
instead of delete
as begin
 delete from Zespol 
  where nazwa = (select Znazwa from deleted)
  
 delete from Klub
  where nazwa = (select Knazwa from deleted)
    
  if(NOT EXISTS(Select Knazwa from deleted, Koncert where Knazwa = [nazwa klubu]))
  begin
   delete from Klub where nazwa = (select Knazwa from deleted)
  end
  
  if(NOT EXISTS(Select Znazwa from deleted, Zespol where Znazwa = nazwa))
  begin
   delete from Zespol where nazwa = (select Znazwa from deleted)
  end
end

