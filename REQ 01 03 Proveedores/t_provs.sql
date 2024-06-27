  CREATE TABLE "T_PROVS" 
   (	"ID" NUMBER, 
      "TITLE" VARCHAR2(30 BYTE), 
      "STATUS" NUMBER,
      "CREATED" DATE, 
      "CREATED_BY" VARCHAR2(20 BYTE), 
      "UPDATED" DATE, 
      "UPDATED_BY" VARCHAR2(20 BYTE) 
--      "RSOCIAL" VARCHAR2(80 BYTE), 
--      "CUIT" VARCHAR2(20 BYTE), 
--      "REVISADO" DATE, 
--      "REVISADO_BY" VARCHAR2(80 BYTE), 
--      "CUENTA_ID" NUMBER, 
--      "OBS" VARCHAR2(200 BYTE), 
--      "SERVICIO" NUMBER, 
--      "BOB_PROV_ID" NUMBER, 
--      "ART_PROV_ID" NUMBER
   ) ;

  CREATE UNIQUE INDEX "PROVEDORES_PK" ON "T_PROVS" ("ID")     ;
  CREATE UNIQUE INDEX "T_PROVS_INDEX1" ON "T_PROVS" ("CUIT")  ;
--------------------------------------------------------
--  DDL for Trigger T_PROVS_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "T_PROVS_TRG" BEFORE
  INSERT OR UPDATE ON "T_PROVS" FOR EACH ROW
DECLARE
  vID number;
BEGIN
  IF :NEW.CUIT IS NOT NULL THEN   
      vid := DFISCALES_PKG.VALIDAR_CUIT(:NEW.CUIT);
  IF vid < 0 THEN
    RAISE_APPLICATION_ERROR(vid,mensaje_error(vid));
  ELSE
    :NEW.CUIT := REPLACE(:NEW.CUIT,'-','');
  END IF;
 END IF;
  IF inserting THEN
    :new.created :=sysdate;
    :new.created_by := nvl(v('APP_USER'),user);
    IF :new.id IS NULL THEN
      SELECT provedores_seq.nextval INTO :new.id
      FROM sys.dual;
    END IF;
  END IF;

  IF updating THEN
    :new.updated :=sysdate;
    :new.updated_by := nvl(v('APP_USER'),user);
  END IF;


END;
/
ALTER TRIGGER "T_PROVS_TRG" ENABLE;
--------------------------------------------------------
--  Constraints for Table T_PROVS
--------------------------------------------------------

  ALTER TABLE "T_PROVS" ADD CONSTRAINT "PROVEDORES_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE;
  ALTER TABLE "T_PROVS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "T_PROVS" MODIFY ("TITLE" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table T_PROVS
--------------------------------------------------------

  ALTER TABLE "T_PROVS" ADD CONSTRAINT "PROVS_FK1" FOREIGN KEY ("CUENTA_ID")
	  REFERENCES "T_CUENTAS" ("ID") ENABLE;
