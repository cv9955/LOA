CREATE TABLE T_COMPRAS_CBTES
(	ID NUMBER NOT NULL, 
    CbteFch DATE NOT NULL, 
    CbteTipo_ID NUMBER NOT NULL, --//
    Concepto_id number not null, --// 1 productos / 2 servicios / 3 productos y servicios
    DocNro NUMBER, 
    PtoVta NUMBER, 
    SIGNO NUMBER(*,0),          --// +1 / -1  
    CTA NUMBER NOT NULL ENABLE, --// 1 
    PROVEDOR_ID NUMBER NOT NULL ENABLE, 
    DFISCAL_ID NUMBER, 
    CUIT VARCHAR2(11 CHAR), 
    PC_CUENTA_ID NUMBER NOT NULL ENABLE, 
    PC_MES VARCHAR2(6) , 
	ImpTotConc NUMBER(*,2) ,   --// Importe neto no gravado.
	ImpNeto NUMBER(*,2) ,      --// Importe neto gravado.
	ImpOpEx NUMBER(*,2) ,      --// Importe exento.
	ImpTrib NUMBER(*,2) ,      --// Suma de los importes del array de tributos
	ImpIVA NUMBER(*,2) ,       --// Suma de los importes del array de IVA.
	ImpTotal NUMBER(*,2) ,     --// Importe total del comprobante
	OBS VARCHAR2(80), 
	STATUS NUMBER, --// 1 CREATED
	CREATED DATE, 
	CREATED_BY VARCHAR2(255), 
	UPDATED DATE, 
	UPDATED_BY VARCHAR2(255),
    CONSTRAINT T_COMPRAS_CBTES_PK PRIMARY KEY (ID)
);
/

create table T_COMPRAS_ITEMS(
    id number not null,
    CBTE_ID NUMBER NOT NULL,
    articulo_id integer,
    detalle varchar2(80),
    cantidad number(*,2),
    precio  number(*,2),
    neto number(*,2),
    ivaTipoId number,
    iva number(*,2),
    CONSTRAINT T_COMPRAS_ITEMS_PK PRIMARY KEY (ID)

    );
/
create table T_COMPRAS_TRIBS(
    id number not null,
    CBTE_ID NUMBER NOT NULL,
    tributoTipoID number,
    valor number(*,2),
    CONSTRAINT T_COMPRAS_TRIBS_PK PRIMARY KEY (ID)
)
/
CREATE SEQUENCE COMPRAS_CBTES_SEQ START WITH 1000 NOCACHE;
CREATE SEQUENCE COMPRAS_ITEMS_SEQ START WITH 1000 CACHE 10;
CREATE SEQUENCE COMPRAS_TRIBS_SEQ START WITH 1000 CACHE 10;
/

CREATE OR REPLACE EDITIONABLE TRIGGER COMPRAS_CBTES_T1 BEFORE
    INSERT ON T_COMPRAS_CBTES FOR EACH ROW
BEGIN
    :new.created :=sysdate;
    :new.created_by :=nvl(v('APP_USER'),user);
    :new.status :=1;
    IF:new.id IS NULL THEN
        SELECT COMPRAS_CBTES_SEQ.nextval INTO:new.id FROM sys.dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER COMPRAS_CBTES_T2 BEFORE
    UPDATE ON T_COMPRAS_CBTES FOR EACH ROW
BEGIN
    if :new.status = 3 then 
        :new.updated :=sysdate;
        :new.updated_by :=nvl(v('APP_USER'),user);
    else
        :new.cta := 1;
        :new.status :=2;
    end if;

    SELECT CUIT INTO :NEW.CUIT FROM T_DFISCALES WHERE ID= :NEW.DFISCAL_ID;

    SELECT SUM(NETO),SUM(IVA) INTO :NEW.ImpNeto,:NEW.ImpIVA
        FROM T_COMPRAS_ITEMS
        WHERE CBTE_ID = :NEW.ID;

    SELECT SUM(VALOR) INTO :NEW.ImpTrib
        FROM T_COMPRAS_TRIBS
        WHERE CBTE_ID = :NEW.ID;

    :NEW.ImpTotal := nvl(:new.ImpNeto,0) + nvl(:new.ImpIVA,0) + nvl(:new.ImpTrib,0) + nvl(:new.ImpOpEx,0) + nvl(:new.ImpTotConc,0); 

end;

/

CREATE OR REPLACE EDITIONABLE TRIGGER COMPRAS_ITEMS_T1 BEFORE
    INSERT OR UPDATE ON T_COMPRAS_ITEMS FOR EACH ROW
BEGIN
    IF inserting THEN
        IF:new.id IS NULL THEN
            SELECT COMPRAS_ITEMS_SEQ.nextval INTO:new.id FROM sys.dual;
        END IF;
    END IF;

    if :new.articulo_id is not null then 
        :new.neto := :new.cantidad * :new.precio;
    end if;

    select value * :new.neto into :new.iva 
        from table(AFIP_PKG.IVATIPO)
        where id = :new.ivaTipoId;
END;

/
CREATE OR REPLACE EDITIONABLE TRIGGER COMPRAS_TRIBS_T1 BEFORE
    INSERT OR UPDATE ON T_COMPRAS_TRIBS FOR EACH ROW
BEGIN
    IF inserting THEN
        IF:new.id IS NULL THEN
            SELECT COMPRAS_TRIBS_SEQ.nextval INTO:new.id FROM sys.dual;
        END IF;
    END IF;
END;
/



alter table LOA.T_COMPRAS_ITEMS add constraint COMPRAS_FK1 foreign key(CBTE_ID) references T_COMPRAS_CBTES(ID)
/
alter table LOA.T_COMPRAS_ITEMS add constraint COMPRAS_FK2 foreign key(ARTICULO_ID) references T_ARTICULOS(ID)
/
alter table LOA.T_COMPRAS_TRIBS add constraint COMPRAS_FK3 foreign key(CBTE_ID) references T_COMPRAS_CBTES(ID)
/
alter table LOA.T_COMPRAS_CBTES add constraint COMPRAS_FK4 foreign key(PROVEDOR_ID) references T_PROVS(ID)
/
alter table LOA.T_COMPRAS_CBTES add constraint COMPRAS_FK5 foreign key(DFISCAL_ID) references T_DFISCALES(ID)
/
alter table LOA.T_COMPRAS_CBTES add constraint COMPRAS_FK6 foreign key(PC_CUENTA_ID) references T_PC_CUENTAS(ID)
/
