# REQ 04 : MODULO COMPRAS

## REQ 04 01 : ABM PROVEEDOR
> alta proveedor, Modificacion de datos no sensibles
> Asociar con Cuit / Razon Social
> Cuenta de Impacto por defecto, para destino de compras en plan de cuentas


## REQ 04 02 : LISTAR PROVEEDORES
> Lista de Valores, Id / Title, para completar listas de seleccion
> agrupado por Cuenta de Impacto


## REQ 04 03 : INGRESAR COMPROBANTES DE COMPRAS
> se ingresa factura de compras , sin impacto en stock. 
> No requiere Orden de compra previa, ni remito de entrega de materiales
- Roles : ADMINISTRATIVO_COMPRAS
- Precondicion : Proveedor Existente, Cuit Registrado, aprobada la recepcion de la mercaderia
- Disparardor : Proveedor envia Factura  
- Post Condicion : Factura cargada en sistema - cuenta proveedor actualizada
- Acceso : PAGINA PROVEEDOR -> BTN_AGREGAR_CBTE

Flujo Principal 
1) el sistema abre ventana para carga de datos (ver datos precargados)
2) el Usuario selecciona Razon Social de la lista desplegable 
3) el sistema muestra CUIT
4) el usuario Ingresa Punto de Venta y Nro Factura
5) el usuario selecciona Cuenta de Impacto (LOV PC_DESTINO_COMPRAS )
6) el usuario Carga Importes Netos y selecciona la correspondiente alicuota de iva
7) el sistema Agrega el item al detalle y muestra valores de IVA y subtotales
8) el usuario Carga Selecciona Tributo correspondiente e ingresa el valor
9) el sistema actualiza Totales
10) Finalizada la carga, el usuario presiona BTN_SUBMIT
11) el sistema Inserta los datos en la Base de Datos 
12) el sistema calcula los totales
13) Se cierra la ventana y devuelve el control a la Pagina PROVEEDOR

- Controles
Unicidad [ Cuit / Punto de Venta / Nro de Factura ]
Total > CERO

- Excepciones 
Proveedor no se encuentra en sistema : Ejecutar CU Alta Proveedor
No existe Razon Social : Ejecutar CU Asignar CUIT
No Se encuentra CUENTA IMPACTO adecuado : Ejecutar CU Alta Cuenta Impacto Compras




- REQ 04 04 : LISTAR CBTES PENDIENTES
- REQ 04 05 : GENERAR ORDEN DE PAGO
- REQ 04 06 : IMPRIMIR ORDEN DE PAGO
- REQ 04 07 : APLICAR PAGO A COMPROBANTES
- REQ 04 08 : BLOQUEAR COMPROBANTES SALDADOS 



### PAGOS
