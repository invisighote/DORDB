CREATE OR REPLACE PROCEDURE NOVA_VYPUJCKA 
(
  OSOBNI_CISLO_IN IN VARCHAR2  
  ,SPZ_IN IN VARCHAR2  
  ,DATUM_IN IN DATE
) AS 
BEGIN
  
  declare
    rid number;
    vid number;
    cnt number;
    dt date;
  begin
    begin
    
      select ridic_id into rid from ridici where osobni_cislo = OSOBNI_CISLO_IN;
    
    EXCEPTION WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('ridic nebyl nalezen');
       return;
    end;
    
    begin
    
      select vozidlo_id into vid from vozidlo where spz = SPZ_IN;
    
    EXCEPTION WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('spz nebyla nalezena');
       return;
    end;
    
    select count(*) into cnt from vypujceni where ridic_id = rid and vozidlo_id = vid and datum_vraceni is null;
    
    if cnt > 0 then
      DBMS_OUTPUT.PUT_LINE('jiz existuje otevrena vypujcka');
      return;
    end if;
    
    select max(datum_vraceni) into dt from vypujceni where ridic_id = rid and vozidlo_id = vid;
  
    if dt is not null and dt >= DATUM_IN then
      DBMS_OUTPUT.PUT_LINE('zasahuje do jine vypujcky');
      return;
    end if;
    
    insert into vypujceni (datum_vypujceni, ridic_id, vozidlo_id, vzdalenost_celkem) values (DATUM_IN, rid, vid, 0);
    
    DBMS_OUTPUT.PUT_LINE('vypujceni bylo zalozeno');
    
  end;
  
END NOVA_VYPUJCKA;
/

CREATE OR REPLACE PROCEDURE NOVA_JIZDA 
(
  OSOBNI_CISLO_IN IN VARCHAR2  
, SPZ_IN IN VARCHAR2  
, DATUM_IN IN DATE  
, START_IN IN VARCHAR2  
, CIL_IN IN VARCHAR2  
, VZDALENOST_IN IN NUMBER  
) AS 
BEGIN
  
  declare
    rid number;
    vid number;
    vyid number;
    cnt number;
    dt date;
    s number;
  begin
    begin
    
      select ridic_id into rid from ridici where osobni_cislo = OSOBNI_CISLO_IN;
    
    EXCEPTION WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('ridic nebyl nalezen');
       return;
    end;
    
     begin
    
      select vozidlo_id into vid from vozidlo where spz = SPZ_IN;
    
    EXCEPTION WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('spz nebyla nalezena');
       return;
    end;
    
    begin
    
      select vypujcka_id into vyid from vypujceni where ridic_id = rid and vozidlo_id = vid and datum_vypujceni <= DATUM_IN and datum_vraceni is null;
    
    EXCEPTION WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('neni k dispizici otevrena vypujcka');
       return;
    end;
    
    insert into jizdy ("START", cil, datum, vzdalenost, vypujceni_id) values (START_IN, CIL_IN, DATUM_IN, VZDALENOST_IN, vyid);
    
    DBMS_OUTPUT.PUT_LINE('jizda byla zalozena');
    
    select sum(vzdalenost) into s from jizdy j where j.vypujceni_id = vyid;
    
    update vypujceni set vzdalenost_celkem = s where vypujcka_id = vyid;
    
    DBMS_OUTPUT.PUT_LINE('vzdalenost_celkem aktualizovana');
    
  end;
  
END NOVA_JIZDA;
/