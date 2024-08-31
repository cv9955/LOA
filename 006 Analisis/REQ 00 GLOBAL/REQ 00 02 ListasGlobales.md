| Lista | Descripcion | Almacenamiento | Abm | utilizacion
|-|-|-|-|-
| Provincias | LOV_PROVINCIAS 
| Partidos | LOV_PARTIDOS 




# Configuracion de Tipos

### REQ 00 02 01 TIPOS DE COMPROBANTES
> Se crea una tabla con la informacion para cada opcion de comprobante, voy agregando campos segun necesidad
Tabla : t_cbte_tipos
Columnas extraidas de webservice de afip : id title letra  
Agrego las siguientes Columnas
- key varchar(20): abreviacion para mostrar en informes , ej Fac A , N/D .... 
- signo : -1 para Notas de Credito , Importes negativos
- flg_compras number : filtro los comprobantes que son opcion para Compras Proveedor
- flg_ventas number  : opciones de facturacion, se asigna a cada cliente un comprobante default , ej FCE... 





Documentos
Articulos
 