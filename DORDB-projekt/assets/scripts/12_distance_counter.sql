---- PRIDA SLOUPEC
ALTER TABLE RIDICI ADD (PRUMER_VZDALENOST NUMBER(10));

----PROCEDURA
CREATE OR REPLACE PROCEDURE AVR_DISTANCE_COUNTER (JID in number) AS 

RID number;
POCET_JIZD number;
CELKEM number;
PRUMER number;

BEGIN
  SELECT v.ridic_id INTO RID from vypujceni v inner join jizdy j 
  on v.vypujcka_id = j.vypujceni_id 
  where j.jizda_id = JID; 

  SELECT COUNT(j.jizda_id) INTO POCET_JIZD FROM JIZDY j INNER JOIN VYPUJCENI ON
  j.vypujceni_id = vypujceni.vypujcka_id
  where VYPUJCENI.RIDIC_ID = RID;
  
  SELECT SUM(v.vzdalenost_celkem) INTO CELKEM FROM vypujceni v WHERE v.ridic_id = RID;
  
  PRUMER := CELKEM / POCET_JIZD;
  UPDATE RIDICI SET PRUMER_VZDALENOST = PRUMER WHERE RIDICI.RIDIC_ID = RID;
END;

----TRIGGER
CREATE OR REPLACE TRIGGER SET_AVR_DRIVER_DISTANCE 
AFTER INSERT OR DELETE OR UPDATE ON JIZDY
for each row
BEGIN
  AVR_DISTANCE_COUNTER(:NEW.jizda_id);
END;
/
SELECT v.ridic_id from vypujceni v inner join jizdy j 
  on v.vypujcka_id = j.vypujceni_id 
  where j.jizda_id = 15; 
SELECT COUNT(j.jizda_id) FROM JIZDY j INNER JOIN VYPUJCENI ON
  j.vypujceni_id = vypujceni.vypujcka_id
  where VYPUJCENI.RIDIC_ID = 15;
