# REQ 03 01 - FACTURACION
> generar facturas desde remitos confirmados
> generar facturas / nd / nc 
> aplicar facturas a remitos
> referenciar nd / nc a facturas ?? 
> exportar libro ventas



## tablas
t_vta_cbtes
t_vta_items
t_vta_tribs

t_vta_applys ( facturas con remitos Y recibos)
t_vta_recibos

t_vta_remitos
t_vta_detalle


# VENTAS_PKG
- PREPARAR_CBTE
- SOLICITAR_CAE
- APLICAR_CBTE
- BORRAR_APLICACION
- BORRAR_CBTE
- FACTURAR_REMITO

# RECIBOS_PKG
- PREPARAR_RECIBO


# DOCS_PKG
- ADD_TO_RECIBO
- DEL_FROM_RECIBO
- TOTAL_RECIBO

