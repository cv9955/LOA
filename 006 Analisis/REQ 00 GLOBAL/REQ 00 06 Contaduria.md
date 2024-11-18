# Contaduria
> Esta Modulo se encarga de los movimientos de valores
> Determina tipo de documentos y su tratamiento
> Se utiliza en los Modulos Pagos y Recibos
> Controla todos los movimientos internos


| 1  | EFT  | EFECTIVO
| 2  | TRF  | TRANSFERENCIA       
| 3  | DEB  | DEBITO BANCARIO
| 4  | TC   | TARJETA DE CRETIDO
| 5  | TD   | TARJETA DE DEBITO
| 6  | QR   | BILLETERA VIRTUAL
| 98 | RED  | REDONDEO
| 99 | CMP  | COMPENSACION

TABLA FORMAS DE PAGO

T_FORMAS_DE_PAGO
- ID
- DOC_TIPO_ID
- DETALLE
- PC_CUENTA_OUT
- STATUS


T_DOCS
