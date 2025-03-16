# REQ 00 04 WebService Afip


## REQ 00 04 01 Mantener Actualizados las listas de parametros
1) CbteTipo RETURN list_cbte_afip;
2) IvaTipo RETURN list_with_value;
3) TributoTipo RETURN list_by_id;
4) DocTipo RETURN list_by_id;



## REQ 00 04 02 WSFE - Web Service Factura Electronica
1) Recuperar lista de parametros
2) Recuperar ultimo Nro de Combrobate
3) Solicitar CAE

## REQ 00 04 03 WSFEX - Web Service Factura Electronica de Exportacion
1) Recuperar lista de parametros
2) Recuperar ultimo Nro de Combrobate
3) Solicitar CAE



# Tablas

## tipo de comprobantes
t_cbte_tipos
- id
- title
- key
- flg_tipo
- flg_exp
- flg_iva
- signo
- status
- flg_compras
- flg_wsfe

