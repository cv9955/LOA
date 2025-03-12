# REQ 03 01 - FACTURACION
> generar facturas desde remitos confirmados
> generar facturas / nd / nc 
> aplicar facturas a remitos
> referenciar nd / nc a facturas ?? 
> exportar libro ventas



## tablas
[OK] t_vta_facturas
[OK] t_vta_factura_it
[OK] t_vta_factura_asoc 
[OK] t_vta_applys 

[] t_vta_recibos
[] t_vta_remitos
[] t_vta_remito_its

## VISTAS
[OK] v_vta_facturas
[OK] v_vta_factura_its


[ok] v_vta_factura_asoc
> lista de facturas asociadas a una Nota de Credito o Debito
```sql
SELECT ac.id
      ,ac.vta_cbte_id
      ,ac.vta_factura_id
      ,fc.title
      ,fc.cbtetipo_id
      ,fc.ptovta
      ,fc.docnro
      ,fc.cbtefch
      ,fc.cuit
      ,fc.dfiscal_id
      ,fc.cliente_id
      ,fc.total
  FROM t_vta_factura_asoc ac
      ,v_vta_facturas     fc
 WHERE fc.id = ac.vta_factura_id;
 ```

[ok] v_vta_factura_ref 
> lista de Notas de Credito o Debito que estan referenciando a una factura
```sql
SELECT ac.id
      ,ac.vta_cbte_id
      ,ac.vta_factura_id
      ,fc.cbtetipo_id
      ,fc.ptovta
      ,fc.docnro
      ,fc.cuit
      ,fc.cbtefch
      ,fc.title
      ,fc.total
      ,fc.cliente_id
      ,fc.dfiscal_id
  FROM t_vta_factura_asoc ac
      ,v_vta_facturas     fc
 WHERE fc.id = ac.vta_cbte_id;
 ```

[OK] v_vta_factura_pmpe 
> promedio ponderados de demora en pagos de factura
```sql
SELECT vta_factura_id,round(sum(acum) / sum(importe))dias
  FROM(
        SELECT app.vta_factura_id 
              ,app.importe
              ,(rec.pmpefch - fac.cbtefch)* app.importe acum
          FROM t_vta_applys  app
              ,t_vta_facturas  fac
              ,t_vta_recibos rec
         WHERE app.vta_factura_id = fac.id(+)
         AND app.vta_recibo_id = rec.id(+)
         AND app.vta_remito_id IS NULL
    )group by vta_factura_id
```


[OK] RECIBOS_APLICADOS_POR_REMITO
[OK] REMITOS_APLICADOS_POR_CBTE
[OK] CBTES_APLICADOS_POR_REMITO
[OK] CBTES_APLICADOS_POR_RECIBO
[OK] RECIBOS_APLICADOS_POR_CBTE
[OK] REMITOS_APLICADOS_POR_RECIBO

## FUNCIONES
[OK] LISTAGG_RECIBOS_POR_REMITO
[OK] LISTAGG_FACTURAS_POR_RECIBO
[OK] LISTAGG_FACTURAS_POR_REMITO
[OK] LISTAGG_RECIBOS_POR_FACTURA
[OK] LISTAGG_REMITOS_POR_FACTURA



## PACKAGES


# FACTURACION_PKG



# APLICACION_PKG
    PROCEDURE recibo_a_cbte     (p_vta_recibo_id  NUMBER,p_vta_cbte_id NUMBER);
    PROCEDURE recibo_a_remito   (p_vta_recibo_id NUMBER,p_vta_remito_id NUMBER);
    PROCEDURE cbte_a_remito     (p_vta_cbte_id NUMBER,p_vta_remito_id NUMBER);
    PROCEDURE eliminar  (p_vta_apply_id  NUMBER);

    PROCEDURE actualizar_saldo_recibo   (p_vta_recibo_id NUMBER);
    PROCEDURE actualizar_saldo_remito   (p_vta_remito_id NUMBER);
    PROCEDURE actualizar_neto_sin_remito(p_vta_cbte_id NUMBER);
    PROCEDURE actualizar_saldo_cbte     (p_vta_cbte_id NUMBER);
       
    function total_por_recibo   (p_vta_recibo_id number) return number;
    function total_por_remito   (p_vta_remito_id number) return number;
    function pagado_por_cbte    (p_vta_cbte_id number) return number;
    function remitido_por_cbte  (p_vta_cbte_id number) return number;

# REMITOS_PKG

# RECIBOS_PKG
- PREPARAR_RECIBO


# PRINT_FACTURA

# EXPORT_TO_EXCEL


# VENTAS_PKG
- PREPARAR_CBTE
- SOLICITAR_CAE
- APLICAR_CBTE
- BORRAR_APLICACION
- BORRAR_CBTE
- FACTURAR_REMITO



# DOCS_PKG
- ADD_TO_RECIBO
- DEL_FROM_RECIBO
- TOTAL_RECIBO


# PAGINAS

P72
P71
P123
