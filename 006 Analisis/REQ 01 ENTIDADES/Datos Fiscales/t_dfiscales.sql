--------------------------------------------------------
-- Archivo creado  - viernes-junio-28-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table T_DFISCALES
--------------------------------------------------------

  CREATE TABLE "T_DFISCALES" 
   (	"ID" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 10000 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
      "TITLE" VARCHAR2(400 CHAR), 
      "CUIT" VARCHAR2(11 CHAR), 
      "DOMICILIO" VARCHAR2(400 CHAR), 
      "CIUDAD" VARCHAR2(80 CHAR), 
      "CP" VARCHAR2(10 CHAR), 
      "PROVINCIA_ID" NUMBER, 
      "PARTIDO_ID" NUMBER, 
      "TIPO_PERSONA" NUMBER, 
      "IMP_GANANCIAS" VARCHAR2(2 CHAR), 
      "IMP_IVA" VARCHAR2(2 CHAR), 
      "MONOTRIBUTO" VARCHAR2(2 CHAR), 
      "INTEGRANTE_SOC" VARCHAR2(1 CHAR), 
      "EMPLEADOR" VARCHAR2(1 CHAR), 
      "ACT_MONOTRIBUTO" VARCHAR2(2 CHAR), 
      "CREATED" DATE, 
      "CREATED_BY" VARCHAR2(255 CHAR), 
      "UPDATED" DATE, 
      "UPDATED_BY" VARCHAR2(255 CHAR), 
      "CLIENTE_ID" NUMBER, 
      "PROVEDOR_ID" NUMBER, 
      "STATUS" NUMBER, 
      "CAB_TIPO_VENTA" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Index T_DFISCALES_CUIT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "T_DFISCALES_CUIT_PK" ON "T_DFISCALES" ("CUIT") 
  ;
--------------------------------------------------------
--  DDL for Index T_DFISCALES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "T_DFISCALES_PK" ON "T_DFISCALES" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index DFISCALES_PROV_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DFISCALES_PROV_UK" ON "T_DFISCALES" ("PROVEDOR_ID") 
  ;
--------------------------------------------------------
--  DDL for Trigger T_DFISCALES_BIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "T_DFISCALES_BIU" 
    before insert or update
    on t_dfiscales
    for each row
declare 
    v_id number;
    v_cuit varchar2(11);
begin

    :NEW.CUIT := REPLACE(:NEW.CUIT,'-','');  
    IF DFISCALES_PKG.VALIDAR_CUIT(:NEW.CUIT) < 0 THEN
        RAISE_APPLICATION_ERROR(-20000,'CUIT INVALIDO');
    END IF;
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);

end t_dfiscales_biu;
/
ALTER TRIGGER "T_DFISCALES_BIU" ENABLE;
--------------------------------------------------------
--  Constraints for Table T_DFISCALES
--------------------------------------------------------

  ALTER TABLE "T_DFISCALES" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "T_DFISCALES" MODIFY ("CREATED" NOT NULL ENABLE);
  ALTER TABLE "T_DFISCALES" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "T_DFISCALES" MODIFY ("UPDATED" NOT NULL ENABLE);
  ALTER TABLE "T_DFISCALES" MODIFY ("UPDATED_BY" NOT NULL ENABLE);
  ALTER TABLE "T_DFISCALES" ADD CONSTRAINT "T_DFISCALES_PK" PRIMARY KEY ("ID")  USING INDEX  ENABLE;
  ALTER TABLE "T_DFISCALES" ADD CONSTRAINT "DFISCALES_PROV_UK" UNIQUE ("PROVEDOR_ID")  USING INDEX  ENABLE;
  ALTER TABLE "T_DFISCALES" ADD CONSTRAINT "DFISCALES_CUIT_UK" UNIQUE ("CUIT")  USING INDEX  ENABLE;

--------------------------------------------------------
--  Ref Constraints for Table T_DFISCALES
--------------------------------------------------------

  ALTER TABLE "T_DFISCALES" ADD CONSTRAINT "DFISCALES_CLIENTE_FK" FOREIGN KEY ("CLIENTE_ID")	  REFERENCES "T_CLIENTES" ("ID") ENABLE;
  ALTER TABLE "T_DFISCALES" ADD CONSTRAINT "DFISCALES_PROV_FK" FOREIGN KEY ("PROVEDOR_ID")	  REFERENCES "T_PROVS" ("ID") ENABLE;
  ALTER TABLE "T_DFISCALES" ADD CONSTRAINT "DFISCALES_CAB_VENTA_FK" FOREIGN KEY ("CAB_TIPO_VENTA")	  REFERENCES "T_CAB_TIPO" ("ID") ENABLE;
