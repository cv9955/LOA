--create view control_cli_dfiscales as
select 'cli' tabla,ID ,cliente_id,
TITLE ,
CUIT ,
DOMICILIO ,
CIUDAD ,
CP ,
PROVINCIA_ID ,
PARTIDO_ID ,status from t_cli_dfiscal
union all
select 'df' tabla,ID ,cliente_id,
TITLE ,
CUIT ,
DOMICILIO ,
CIUDAD ,
CP ,
PROVINCIA_ID ,
PARTIDO_ID ,status from t_dfiscales
where cliente_id is not null
order by cliente_id,id;

select ID ,
CLIENTE_ID ,
TITLE ,
CUIT ,

COND_PAGO ,
STATUS ,
CAB_TIPO_ID  from t_cli_dfiscal;

select ID ,
TITLE ,
CUIT ,

TIPO_PERSONA ,
IMP_GANANCIAS ,
IMP_IVA ,
MONOTRIBUTO ,
INTEGRANTE_SOC ,
EMPLEADOR ,
ACT_MONOTRIBUTO ,
CLIENTE_ID ,
cab_tipo_venta,
PROVEDOR_ID ,
STATUS  from t_dfiscales;
