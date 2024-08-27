CREATE TABLE "T_CBTE_COMPRAS" 
(	"ID" NUMBER NOT NULL, 
    "CbteFch" DATE NOT NULL, 
    "CbteTipo_ID" NUMBER NOT NULL, --//
    "Concepto_id" number not null, --// 1 productos / 2 servicios / 3 productos y servicios
    "DocNro" NUMBER, 
    "PtoVta" NUMBER, 
    "SIGNO" NUMBER(*,0),          --// +1 / -1  
    "CTA" NUMBER NOT NULL ENABLE, --// 1 
    "PROVEDOR_ID" NUMBER NOT NULL ENABLE, 
    "DFISCAL_ID" NUMBER, 
    "CUIT" VARCHAR2(11 CHAR), 
    "PC_CUENTA_ID" NUMBER NOT NULL ENABLE, 
    "PC_MES" VARCHAR2(6) NOT NULL ENABLE, 
	"ImpTotConc" NUMBER(*,2) NOT NULL ENABLE,   --// Importe neto no gravado.
	"ImpNeto" NUMBER(*,2) NOT NULL ENABLE,      --// Importe neto gravado.
	"ImpOpEx" NUMBER(*,2) NOT NULL ENABLE,      --// Importe exento.
	"ImpTrib" NUMBER(*,2) NOT NULL ENABLE,      --// Suma de los importes del array de tributos
	"ImpIVA" NUMBER(*,2) NOT NULL ENABLE,       --// Suma de los importes del array de IVA.
	"ImpTotal" NUMBER(*,2) NOT NULL ENABLE,     --// Importe total del comprobante
	"OBS" VARCHAR2(80), 
	"STATUS" NUMBER, --// 1 CREATED
	"CREATED" DATE, 
	"CREATED_BY" VARCHAR2(255), 
	"UPDATED" DATE, 
	"UPDATED_BY" VARCHAR2(255)
);

/

CREATE SEQUENCE CBTE_COMPAS_SEQ START WITH 1000 NOCACHE;
/

CREATE OR REPLACE EDITIONABLE TRIGGER "CBTE_COMPRAS_T1" BEFORE
    INSERT OR UPDATE ON "T_CBTE_COMPRAS" FOR EACH ROW
BEGIN
    IF inserting THEN
        :new.created :=sysdate;
        :new.created_by :=nvl(v('APP_USER'),user);
        :new.status :=1;
        IF:new.id IS NULL THEN
            SELECT CBTE_COMPAS_SEQ.nextval INTO:new.id FROM sys.dual;
        END IF;
    END IF;

    IF updating THEN
        :new.updated :=sysdate;
        :new.updated_by :=nvl(v('APP_USER'),user);
    END IF;
END;
/