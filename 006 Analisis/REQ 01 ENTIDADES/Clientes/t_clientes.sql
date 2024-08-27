--------------------------------------------------------
-- Archivo creado  - viernes-junio-28-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table T_CLIENTES
--------------------------------------------------------

  CREATE TABLE "T_CLIENTES" 
   (	"ID" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(200 BYTE), 
	"VENDEDOR_ID" NUMBER(*,0), 
	"ALIAS" VARCHAR2(13 BYTE), 
	"TAGS" VARCHAR2(400 BYTE), 
	"COND_PAGO" NUMBER, 
	"STATUS" NUMBER, 
	"AJ_COMISION" NUMBER, 
	"AJ_COTIZ" NUMBER, 
	"LOGO" BLOB, 
	"MIMETYPE" VARCHAR2(48 BYTE), 
	"FILENAME" VARCHAR2(400 BYTE), 
	"LASTUPDATED" DATE, 
	"CREATED" DATE, 
	"CREATED_BY" VARCHAR2(20 BYTE), 
	"UPDATED" DATE, 
	"UPDATED_BY" VARCHAR2(20 BYTE), 
	"CUENTA_REVISADA" DATE, 
	"CUENTA_REVISADA_BY" VARCHAR2(80 BYTE), 
	"LISTA_PRECIO" NUMBER DEFAULT 0, 
	"OBS" VARCHAR2(400 BYTE), 
	"CAT002" NUMBER, 
	"CAT003" NUMBER, 
	"AJ_FLETE" NUMBER, 
	"STATUS_FEC" DATE
   ) 
 LOB ("LOGO") STORE AS BASICFILE "CLIENTES_LOGO"(ENABLE STORAGE IN ROW 4000 CHUNK 8192 RETENTION 
  CACHE READS LOGGING ) ;
--------------------------------------------------------
--  DDL for Index CLIENTES_I
--------------------------------------------------------

  CREATE INDEX "CLIENTES_I" ON "T_CLIENTES" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Trigger CLIENTES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "CLIENTES_T1" BEFORE
    INSERT OR UPDATE OF nombre,alias,vendedor_id,cond_pago,aj_comision ON "T_CLIENTES" FOR EACH ROW
BEGIN
    IF inserting THEN
        :new.created :=sysdate;
        :new.created_by :=nvl(v('APP_USER'),user);
        :new.status :=0;
        :new.status_fec :=sysdate;
        IF:new.id IS NULL THEN
            SELECT clientes_seq.nextval INTO:new.id
            FROM sys.dual;
        END IF;
    END IF;

    IF updating THEN
        :new.updated :=sysdate;
        :new.updated_by :=nvl(v('APP_USER'),user);
    END IF;
END;
/
ALTER TRIGGER "CLIENTES_T1" ENABLE;
--------------------------------------------------------
--  Constraints for Table T_CLIENTES
--------------------------------------------------------

  ALTER TABLE "T_CLIENTES" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "T_CLIENTES" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "T_CLIENTES" MODIFY ("VENDEDOR_ID" NOT NULL ENABLE);
  ALTER TABLE "T_CLIENTES" MODIFY ("CREATED" NOT NULL ENABLE);
  ALTER TABLE "T_CLIENTES" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "T_CLIENTES" MODIFY ("LISTA_PRECIO" NOT NULL ENABLE);
  ALTER TABLE "T_CLIENTES" ADD CONSTRAINT "CLIENTES_PK" PRIMARY KEY ("ID")
  USING INDEX "CLIENTES_I"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table T_CLIENTES
--------------------------------------------------------

  ALTER TABLE "T_CLIENTES" ADD CONSTRAINT "VENDEDOR_KF1" FOREIGN KEY ("VENDEDOR_ID")
	  REFERENCES "T_CLI_VENDORS" ("ID") ENABLE;
