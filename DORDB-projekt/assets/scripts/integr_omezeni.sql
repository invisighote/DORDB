ALTER TABLE VYPUJCENI ADD CONSTRAINT CK_VYPUJCENI_DATUMY CHECK ((DATUM_VRACENI IS NULL) OR ( DATUM_VRACENI IS NOT NULL AND DATUM_VRACENI >= DATUM_VYPUJCENI)) ENABLE;
/

CREATE OR REPLACE TRIGGER CKECK_JIZDY_DATUM 
BEFORE INSERT OR UPDATE ON JIZDY 
FOR EACH ROW 
BEGIN
  
  declare
    dt DATE;
  begin
  
    select datum_vypujceni into dt from vypujceni where vypujcka_id = :NEW.vypujceni_id;
    
    if dt > :NEW.datum
    then
      raise_application_error(-20000, 'Neproslo pres integritni omezeni, ze datum nesmy byt mensi!');
    end if;

  
  end;
  
END;
/