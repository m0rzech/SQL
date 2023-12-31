#rok 2004
drop table if exists rok2004;
create table rok2004(
					miesiac int(30) , 
					wynik decimal(10,2));
drop procedure if exists fil;
DELIMITER $$
CREATE procedure fil()
BEGIN
	declare a int;
	set a = 1;
	while (a < 30) DO
		IF (a%12=0) THEN
			Insert into rok2004(miesiac,wynik) values (12, RAND()*10000);
		ELSE
			Insert into rok2004(miesiac,wynik) values ((a%12), RAND()*10000);
        END IF;
		set a = a+1;
    END WHILE;
end $$
DELIMITER ;
call fil();

#rok 2005
drop table if exists rok2005;
create table rok2005(
					miesiac int(30) , 
					wynik decimal(10,2));
drop procedure if exists fil2;
DELIMITER $$

CREATE procedure fil2()
BEGIN
	declare a int;
	set a = 1;
	while (a < 30) DO
		IF (a%12=0) THEN
			Insert into rok2005(miesiac,wynik) values (12, RAND()*10000);
		ELSE
			Insert into rok2005(miesiac,wynik) values ((a%12), RAND()*10000);
		END IF;
		set a = a+1;
    END WHILE;
end $$
DELIMITER ;
call fil2();

drop PROCEDURE if EXISTS zadanie;
drop TABLE if EXISTS t1;
DELIMITER $$
CREATE PROCEDURE zadanie() 
BEGIN   
	DECLARE wynik INT;
	declare wynik2004 int;
	declare wynik2005 int;
	declare rok int;
	declare mies int;
	set mies = 1;
    	CREATE TABLE t1(miesiac int, rok int, wynik int);
	while (mies<13) DO    		
		SELECT MAX(rok2004.wynik) INTO wynik2004 FROM rok2004 WHERE miesiac = mies;
		SELECT MAX(rok2005.wynik) INTO wynik2005 FROM rok2005 WHERE miesiac = mies;
		
		if (wynik2004>wynik2005) THEN
			set wynik = wynik2004;
			set rok = 2004;
		else 
			set wynik = wynik2005 ;
			set rok = 2005;
		END IF;			   
		INSERT INTO t1 values (mies, rok, wynik);
		set mies = mies + 1;
	END WHILE;
END $$
DELIMITER ;
CALL zadanie();
select * FROM t1;