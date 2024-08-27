--------------------------------------------------------
--  DDL for Table PLAN DE CUENTAS

CREATE TABLE "T_PC_RUBROS" 
  (	"ID" NUMBER PRIMARY KEY NOT NULL, 
    "PARENT_ID" NUMBER NOT NULL, 
    "DETALLE" VARCHAR2(80 BYTE) NOT NULL,
    "CUENTA_TIPO_KEY" VARCHAR2(400 BYTE)
  ) ;

/

CREATE OR REPLACE TRIGGER PC_RUBROS_BI 
BEFORE INSERT ON T_PC_RUBROS 
FOR EACH ROW 
BEGIN
    IF :NEW.ID IS NULL THEN 
        :NEW.ID := plan_cuentas_pkg.siguiente_rubro_id(:NEW.PARENT_ID);
    END IF;
END;
/

create or replace view v_pc_rubros as
SELECT id
      ,parent_id
      ,DETALLE
      ,CUENTA_TIPO_KEY
      ,TO_CHAR(ID,'000') || ' - ' || DETALLE TITLE
  FROM T_PC_RUBROS;



REM INSERTING into T_PC_RUBROS
SET DEFINE OFF;
Insert into T_PC_RUBROS (ID,PARENT_ID,DETALLE) values ('111','11','Caja');
Insert into T_PC_RUBROS (ID,PARENT_ID,DETALLE) values ('112','11','Banco');
Insert into T_PC_RUBROS (ID,PARENT_ID,DETALLE) values ('121','12','Inversiones No Corrientes');
Insert into T_PC_RUBROS (ID,PARENT_ID,DETALLE) values ('122','12','Bienes de uso');
Insert into T_PC_RUBROS (ID,PARENT_ID,DETALLE) values ('211','21','Cta cte Proveedores');
Insert into T_PC_RUBROS (ID,PARENT_ID,DETALLE) values ('311','31','Aportes');
Insert into T_PC_RUBROS (ID,PARENT_ID,DETALLE) values ('312','31','Reservas');
Insert into T_PC_RUBROS (ID,PARENT_ID,DETALLE) values ('313','31','Resultados');
Insert into T_PC_RUBROS (ID,PARENT_ID,DETALLE) values ('411','41','Ingresos por Ventas');
Insert into T_PC_RUBROS (ID,PARENT_ID,DETALLE) values ('511','51','Gastos Administrativos');
Insert into T_PC_RUBROS (ID,PARENT_ID,DETALLE) values ('521','52','Honorarios');



