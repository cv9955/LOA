--------------------------------------------------------
-- Archivo creado  - martes-julio-02-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table T_CUENTA_RUBROS
--------------------------------------------------------

  CREATE TABLE "T_CUENTA_RUBROS" 
   (	"ID" NUMBER, 
	"PARENT" NUMBER, 
	"TITLE" VARCHAR2(80 BYTE)
   ) ;
REM INSERTING into T_CUENTA_RUBROS
SET DEFINE OFF;
Insert into T_CUENTA_RUBROS (ID,PARENT,TITLE) values ('311','31','Aportes');
Insert into T_CUENTA_RUBROS (ID,PARENT,TITLE) values ('111','11','Caja');
Insert into T_CUENTA_RUBROS (ID,PARENT,TITLE) values ('112','11','Banco');
Insert into T_CUENTA_RUBROS (ID,PARENT,TITLE) values ('312','31','Reservas');
Insert into T_CUENTA_RUBROS (ID,PARENT,TITLE) values ('313','31','Resultados');
Insert into T_CUENTA_RUBROS (ID,PARENT,TITLE) values ('521','52','Honorarios');
Insert into T_CUENTA_RUBROS (ID,PARENT,TITLE) values ('411','41','Ingresos por Ventas');
Insert into T_CUENTA_RUBROS (ID,PARENT,TITLE) values ('211','21','Cta cte Proveedores');
Insert into T_CUENTA_RUBROS (ID,PARENT,TITLE) values ('121','12','Inversiones No Corrientes');
Insert into T_CUENTA_RUBROS (ID,PARENT,TITLE) values ('122','12','Bienes de uso');
--------------------------------------------------------
--  DDL for Index T_PLAN_CUENTAS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "T_PLAN_CUENTAS_PK" ON "T_CUENTA_RUBROS" ("ID") 
  ;
--------------------------------------------------------
--  Constraints for Table T_CUENTA_RUBROS
--------------------------------------------------------

  ALTER TABLE "T_CUENTA_RUBROS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "T_CUENTA_RUBROS" MODIFY ("PARENT" NOT NULL ENABLE);
  ALTER TABLE "T_CUENTA_RUBROS" MODIFY ("TITLE" NOT NULL ENABLE);
  ALTER TABLE "T_CUENTA_RUBROS" ADD CONSTRAINT "T_PLAN_CUENTAS_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE;
