TABLAS t_tablename




## CAMPOS
```SQL
"ID" NUMBER NOT NULL, 
"OBS" VARCHAR2(80), --// 1 LINEA MAX 
"NOTAS" VARCHAR2(400), --// VARIAS LINEAS  
"DETALLE" VARCHAR2(80), --// 1 LINEAR, PARA ITEMS   
"STATUS" NUMBER, --// 1 CREATED
```

## AUDIT COLS
```SQL
"CREATED" DATE, 
"CREATED_BY" VARCHAR2(255), 
"UPDATED" DATE, 
"UPDATED_BY" VARCHAR2(255) 
```

## CAMPOS ENTIDADES
```SQL
"PROVEDOR_ID" NUMBER NOT NULL ENABLE, 
"DFISCAL_ID" NUMBER, 
"CUIT" VARCHAR2(11 CHAR), 
```


## CAMPOS PLAN DE CUENTAS
```SQL
"PC_CUENTA_ID" NUMBER NOT NULL ENABLE, 
"PC_MES" VARCHAR2(6) NOT NULL ENABLE, 
```


## CAMPOS CBTES
```SQL
"CbteFch" DATE NOT NULL, 
"CbteTipo_ID" NUMBER NOT NULL, 
"Concepto_id" number not null, --// 1 productos / 2 servicios / 3 productos y servicios
"DocNro" NUMBER, 
"PtoVta" NUMBER, 
"SIGNO" NUMBER(*,0),          --// +1 / -1  
"CTA" NUMBER NOT NULL ENABLE, --// 1 

"ImpTotConc" NUMBER(*,2) NOT NULL ENABLE,   --// Importe neto no gravado.
"ImpNeto" NUMBER(*,2) NOT NULL ENABLE,      --// Importe neto gravado.
"ImpOpEx" NUMBER(*,2) NOT NULL ENABLE,      --// Importe exento.
"ImpTrib" NUMBER(*,2) NOT NULL ENABLE,      --// Suma de los importes del array de tributos
"ImpIVA" NUMBER(*,2) NOT NULL ENABLE,       --// Suma de los importes del array de IVA.
"ImpTotal" NUMBER(*,2) NOT NULL ENABLE,     --// Importe total del comprobante
```

VISTAS v_tablename
- ID
- TITLE
- DESCRIPTION
- STATUS


PAQUETES pkg_packagename



## Buttons - Redirect
- Name : BTN_PAGE_NAME


## Buttons - Back
> Page : &P2110_BACK.


tablas en comun

### COMPROBANTES

T_VTA_FACTURAS
T_VTA_RECIBOS
T_VTA_REMITOS

T_PROV_COMPRAS / T_COMPRAS_CBTES
T_PROV_PAGOS   / T_COMPRAS_PAGOS


ID           NOT NULL NUMBER        
CBTETIPO_ID           NUMBER        
PTOVTA                NUMBER        
DOCNRO                NUMBER        
CBTEFCH      NOT NULL DATE       
SIGNO                 NUMBER(38)    
CTA          NOT NULL NUMBER        

CAB_TIPO_ID  NOT NULL NUMBER        
CONCEPTO_ID           NUMBER        

CLIENTE_ID   NOT NULL NUMBER        
PROVEDOR_ID  NOT NULL NUMBER        
CLI_CUENTA_ID         NUMBER        
DFISCAL_ID            NUMBER        
CUIT                  VARCHAR2(20)  

PC_CUENTA_ID NOT NULL NUMBER        
PC_MES       NOT NULL VARCHAR2(6)   

IMPOPEX               NUMBER        
IMPNETO      NOT NULL NUMBER(38,2)  
IMPTRIB               NUMBER        
IMPIVA       NOT NULL NUMBER(38,2)  
IMPTOTAL     NOT NULL NUMBER(38,2)  

SALDO_PENDIENTE  NOT NULL NUMBER(38,2)   // SALDO 0 SE ARCHIVA !!!


OBS                   VARCHAR2(200) 
STATUS                NUMBER        

CREATED               DATE          
CREATED_BY            VARCHAR2(20)  

UPDATED               DATE          
UPDATED_BY            VARCHAR2(20)  