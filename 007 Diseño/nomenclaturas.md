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
