--------------------------------------------------------
-- Archivo creado  - viernes-junio-28-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table T_PROVS
--------------------------------------------------------

  CREATE TABLE "VIC"."T_PROVS" 
   (	"ID" NUMBER, 
	"TITLE" VARCHAR2(30 BYTE), 
	"RSOCIAL_X" VARCHAR2(80 BYTE), 
	"CUIT_X" VARCHAR2(20 BYTE), 
	"CREATED" DATE, 
	"CREATED_BY" VARCHAR2(20 BYTE), 
	"UPDATED" DATE, 
	"UPDATED_BY" VARCHAR2(20 BYTE), 
	"REVISADO" DATE, 
	"REVISADO_BY" VARCHAR2(80 BYTE), 
	"CUENTA_ID" NUMBER, 
	"OBS" VARCHAR2(200 BYTE), 
	"SERVICIO" NUMBER, 
	"BOB_PROV_ID" NUMBER, 
	"ART_PROV_ID" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Index PROVEDORES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "VIC"."PROVEDORES_PK" ON "VIC"."T_PROVS" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index T_PROVS_INDEX1
--------------------------------------------------------

  CREATE UNIQUE INDEX "VIC"."T_PROVS_INDEX1" ON "VIC"."T_PROVS" ("CUIT_X") 
  ;
--------------------------------------------------------
--  DDL for Trigger T_PROVS_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "VIC"."T_PROVS_TRG" BEFORE
  INSERT OR UPDATE ON "T_PROVS" FOR EACH ROW
DECLARE
  vID number;
BEGIN
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
ALTER TRIGGER "VIC"."T_PROVS_TRG" ENABLE;
--------------------------------------------------------
--  Constraints for Table T_PROVS
--------------------------------------------------------

  ALTER TABLE "VIC"."T_PROVS" ADD CONSTRAINT "PROVEDORES_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE;
  ALTER TABLE "VIC"."T_PROVS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "VIC"."T_PROVS" MODIFY ("TITLE" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table T_PROVS
--------------------------------------------------------

  ALTER TABLE "VIC"."T_PROVS" ADD CONSTRAINT "PROVS_FK1" FOREIGN KEY ("CUENTA_ID")
	  REFERENCES "VIC"."T_CUENTAS" ("ID") ENABLE;
