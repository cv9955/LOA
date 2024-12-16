  CREATE TABLE "T_PROVEEDORES" 
   (	"ID" NUMBER, 
      "TITLE" VARCHAR2(30 BYTE), 
      "STATUS" NUMBER,
      "CREATED" DATE, 
      "CREATED_BY" VARCHAR2(20 BYTE), 
      "UPDATED" DATE, 
      "UPDATED_BY" VARCHAR2(20 BYTE) 
   ) ;

  CREATE UNIQUE INDEX "PROVEDORES_PK" ON "T_PROVS" ("ID")     ;
--------------------------------------------------------
--  DDL for Trigger T_PROVS_TRG
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER "PROVEEDORES_TRG" BEFORE
  INSERT OR UPDATE ON "T_PROVEEDORES" FOR EACH ROW
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
ALTER TRIGGER "PROVEEDORES_TRG" ENABLE;
--------------------------------------------------------
--  Constraints for Table T_PROVS
--------------------------------------------------------

  ALTER TABLE "T_PROVEEDORES" ADD CONSTRAINT "PROVEDORES_PK" PRIMARY KEY ("ID")  USING INDEX  ENABLE;
  ALTER TABLE "T_PROVEEDORES" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "T_PROVEEDORES" MODIFY ("TITLE" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table T_PROVS
--------------------------------------------------------

  ALTER TABLE "T_PROVEEDORES" ADD CONSTRAINT "PROVEEDORES_FK1" FOREIGN KEY ("CUENTA_ID") REFERENCES "T_CUENTAS" ("ID") ENABLE;
