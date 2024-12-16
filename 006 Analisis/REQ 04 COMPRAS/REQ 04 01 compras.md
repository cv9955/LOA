# REQ 04 01 01 : INGRESAR FACTURA DE COMPRAS 
> se ingresa factura de compras , sin impacto en stock. 
> No requiere Orden de compra previa, ni remito de entreda de materiales
Roles : ADM_COMPRAS
Precondicion : Proveedor Existente, Cuit Registrado
Disparardor : Proveedor envia Factura
Post Condicion : Factura cargada en sistema - cuenta proveedor actualizada
Acceso : PAGINA PROVEEDOR

Flujo Principal 
1) el Usuario accede a la pagina del Proveedor
2) presiona BTN_AGREGAR_CBTE
3) el sistema abre ventana para carga de datos (ver datos precargados)
4) el Usuario selecciona Razon Socia de la lista desplegable 
5) el sistema muestra CUIT
6) el usuario Ingresa Punto de Venta y Nro Factura
7) el usuario selecciona Cuenta de Impacto (LOV PC_DESTINO_COMPRAS )
8) el usuario Carga Importes Netos y selecciona la correspondiente alicuota de iva
9) El sistema Agrega el item al detalle y muestra valores de IVA y subtotales
10) el usuario Carga Selecciona Tributo correspondiente e ingresa el valor
11) El sistema actualiza Totales
12) Finalizada la carga, el usuario presiona BTN_SUBMIT
13) el sistema Inserta los datos en la Base de Datos 
14) el sistema calcula los totales
15) Se cierra la ventana y devuelve el control a la Pagina PROVEEDOR




