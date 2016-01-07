delete from OBJ_POBOCKA;
delete from OBJ_MODEL;
delete from OBJ_VOZIDLO;
delete from OBJ_RIDIC;
delete from OBJ_VYPUJCENI;
delete from OBJ_JIZDY;
/
insert into OBJ_POBOCKA (POBOCKA_ID,MESTO,ADRESA,STAT) (SELECT POBOCKA_ID, MESTO,ADRESA,STAT from POBOCKA);
/
insert into OBJ_MODEL (MODEL_ID,ZNACKA,MODEL,OBSAH,SPOTREBA) (SELECT MODEL_ID,ZNACKA,MODEL,OBSAH,SPOTREBA from MODEL);
/
/*NAPLNI VOZIDLO*/
insert into OBJ_VOZIDLO (VOZIDLO_ID,DATUM_PORIZENI,NAJETO,SPZ) (SELECT VOZIDLO_ID,DATUM_PORIZENI,NAJETO,SPZ from VOZIDLO);
/
update OBJ_VOZIDLO ov set ov.MODEL_ID = (
	select REF(ovt) from OBJ_MODEL ovt where ovt.MODEL_ID = (
		select v.MODEL_ID from VOZIDLO v where v.VOZIDLO_ID = ov.VOZIDLO_ID
	)
);
/
update OBJ_VOZIDLO op set op.POBOCKA_ID = (
	select REF(obp) from OBJ_POBOCKA obp where obp.POBOCKA_ID = (
		select v.POBOCKA_ID from VOZIDLO v where v.VOZIDLO_ID = op.VOZIDLO_ID
	)
);
/
/*NAPLNI RIDICE*/
insert into OBJ_RIDIC (RIDIC_ID,JMENO,PRIJMENI) (SELECT RIDIC_ID,JMENO,PRIJMENI from RIDICI);
/
update OBJ_RIDIC obt set obt.POBOCKA_ID = (
	select REF(obp) from OBJ_POBOCKA obp where obp.POBOCKA_ID = (
		select r.POBOCKA_ID from RIDICI r where r.RIDIC_ID = obt.RIDIC_ID
	)
);
/
/*NAPLNI VYPUJCKY*/
insert into OBJ_VYPUJCENI (VYPUJCKA_ID,DATUM_VYPUJCENI,DATUM_VRACENI,VZDALENOST_CELKEM) (SELECT VYPUJCKA_ID,DATUM_VYPUJCENI,DATUM_VRACENI,VZDALENOST_CELKEM FROM vypujceni);
/
update OBJ_VYPUJCENI obv set obv.RIDIC_ID = (
	select REF(obr) from OBJ_RIDIC obr where obr.RIDIC_ID = (
		select vyp.RIDIC_ID from VYPUJCENI vyp where vyp.VYPUJCKA_ID = obv.VYPUJCKA_ID
	)
);
/
update OBJ_VYPUJCENI voz set voz.VOZIDLO_ID = (
	select REF(obvz) from OBJ_VOZIDLO obvz where obvz.VOZIDLO_ID = (
		select vyp.VOZIDLO_ID from VYPUJCENI vyp where vyp.VYPUJCKA_ID = voz.VYPUJCKA_ID
	)
);
/
/*NAPLNI JIZDY*/
insert into OBJ_JIZDY (JIZDY_ID,"START",CIL,DATUM,VZDALENOST) (SELECT JIZDA_ID,"START",CIL,DATUM,VZDALENOST FROM JIZDY);
/
UPDATE OBJ_JIZDY obj set obj.vypujceni_id = (
  select REF(ovr) from obj_vypujceni ovr where ovr.vypujcka_id = (
    select j.vypujceni_id from jizdy j where j.jizda_id = obj.jizdy_id
    )
);
/