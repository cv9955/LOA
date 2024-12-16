CREATE TABLE "T_CBTE_TIPOS" 
   (	"ID" NUMBER, 
        "TITLE" VARCHAR2(400), 
        "LETRA" CHAR(1), 
        "FLG_COMPRAS" NUMBER, 
        "FLG_VENTAS" NUMBER, 
        "KEY" VARCHAR2(20)
   ) ;
/

alter table T_CBTE_TIPOS add signo integer;

/
create or replace view v_cbte_tipos as 
select ID
    ,TITLE
    ,LETRA
    ,FLG_COMPRAS
    ,FLG_VENTAS
    ,KEY
    ,SIGNO
    from T_CBTE_TIPOS;

    