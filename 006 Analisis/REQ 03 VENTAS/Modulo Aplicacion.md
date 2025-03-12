## tablas
[OK] t_vta_applys 

![DER](der_aplicacion.pdf.png)

[] t_vta_facturas
[] t_vta_recibos
[] t_vta_remitos

## VISTAS
[OK] RECIBOS_APLICADOS_POR_REMITO
[OK] REMITOS_APLICADOS_POR_CBTE
[OK] CBTES_APLICADOS_POR_REMITO
[OK] CBTES_APLICADOS_POR_RECIBO
[OK] RECIBOS_APLICADOS_POR_CBTE
[OK] REMITOS_APLICADOS_POR_RECIBO

[OK] pmpe_cabs  (promedio ponderado tiempo de pago)

## FUNCIONES
[OK] LISTAGG_RECIBOS_POR_REMITO
[OK] LISTAGG_FACTURAS_POR_RECIBO
[OK] LISTAGG_FACTURAS_POR_REMITO
[OK] LISTAGG_RECIBOS_POR_FACTURA
[OK] LISTAGG_REMITOS_POR_FACTURA

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