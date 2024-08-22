/* agregar campo cuenta_tipo a tabla t_cuenta_rubros*/
ALTER TABLE t_cuenta_rubros ADD(
    cuenta_tipo VARCHAR2(20)
);

/* TRIGGER PARA BUSCAR SIGUIENTE RUBRO _ ID */ 
CREATE OR REPLACE TRIGGER CUENTA_RUBROS_BI 
BEFORE INSERT ON T_CUENTA_RUBROS 
FOR EACH ROW 
BEGIN
    IF :NEW.ID IS NULL THEN 
        :NEW.ID := plan_cuentas_pkg.siguiente_rubro_id(:NEW.PARENT);
    END IF;
END;


/

/* corregir vistas */
create or replace view v_pc_rubros as
SELECT id
      ,parent
      ,title
      ,cuenta_tipo
  FROM t_cuenta_rubros;

  

