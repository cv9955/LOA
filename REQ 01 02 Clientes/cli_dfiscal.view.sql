--------------------------------------------------------
-- Archivo creado  - viernes-junio-28-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View CLI_DFISCAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "CLI_DFISCALES" ("ID", "CLIENTE_ID", "TITLE", "CUIT", "DOMICILIO", "CIUDAD", "CP", "PROVINCIA_ID", "PARTIDO_ID", "STATUS", "CAB_TIPO_ID", "JUR") AS 
  SELECT id
      ,cliente_id
      ,title
      ,cuit
      ,domicilio
      ,ciudad
      ,cp
      ,provincia_id
      ,partido_id
   --   ,vta_cond_pago cond_pago
      ,status
  --    ,created      ,created_by      ,updated      ,updated_by -- eliminar
  --    ,div_audit(created,created_by,updated,updated_by) audit_cols
      ,cab_tipo_venta cab_tipo_id  -- tipo de factura por cliente
      ,CASE WHEN provincia_id=2 THEN 154 ELSE 155 END jur -- REVISAR SI SE USA SOLO EN COPY_FACT_VENTAS
  FROM t_dfiscales
   where cliente_id is not null
;
