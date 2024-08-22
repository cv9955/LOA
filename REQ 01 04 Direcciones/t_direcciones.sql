
  CREATE TABLE "T_DIRECCIONES" 
  (
    "DIR_HASH" RAW(20), 
	"TITLE" VARCHAR2(400 CHAR), 
	"NUMERO" VARCHAR2(20 BYTE), 
	"CALLE" VARCHAR2(100 BYTE), 
	"LOCALIDAD" VARCHAR2(100 BYTE), 
	"PROVINCIA" VARCHAR2(50 BYTE), 
	"COD_POSTAL" VARCHAR2(20 BYTE), 
	"PAIS" VARCHAR2(20 BYTE), 
	"LAT" NUMBER(8,4), 
	"LNG" NUMBER(8,4)
   ) ;
--------------------------------------------------------
--  DDL for Index DIRECCIONES_PK
--------------------------------------------------------
 ALTER TABLE "T_DIRECCIONES" ADD CONSTRAINT "DIRECCIONES_PK" PRIMARY KEY ("DIR_HASH")  USING INDEX  ENABLE;

--------------------------------------------------------
--  DDL for Trigger DIRECCIONES_T1
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER "DIRECCIONES_T1" 
    BEFORE INSERT OR UPDATE ON "T_DIRECCIONES" 
    FOR EACH ROW 
BEGIN
    SELECT 
        standard_hash(
            TO_CHAR(:new.LAT,'FM000D0000') ||
            TO_CHAR(:new.LNG,'FM000D0000') 
                ,'SHA1') 
    INTO :new.DIR_HASH
    FROM dual;
END;
/
ALTER TRIGGER "DIRECCIONES_T1" ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table T_DIRECCIONES
--------------------------------------------------------

