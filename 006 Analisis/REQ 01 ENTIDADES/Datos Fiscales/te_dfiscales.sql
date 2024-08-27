--## Archivo Padron.txt
--> Archivo descargado de la pag AFIP. 
--> Directorio /home/oracle/DP

create directory DP as '/home/oracle/DP';

--## Copiar Archivo desde otro servidor
--
-- scp -P 1599 oracle@179.41.5.74:/media/oracle/padron.txt .
--

--## Crear tabla externa

CREATE TABLE te_dfiscales(
    cuit            CHAR(11 BYTE)
    ,title           CHAR(30 BYTE)
    ,imp_ganancias   CHAR(2 BYTE)
    ,imp_iva         CHAR(2 BYTE)
    ,monotributo     CHAR(2 BYTE)
    ,integrante_soc  CHAR(1 BYTE)
    ,empleador       CHAR(1 BYTE)
    ,act_monotributo CHAR(2 BYTE)
)
ORGANIZATION EXTERNAL(TYPE oracle_loader
    DEFAULT DIRECTORY dp ACCESS PARAMETERS(
        RECORDS DELIMITED BY NEWLINE
        FIELDS(
            cuit CHAR(11)
            ,title CHAR(30)
            ,imp_ganancias CHAR(2)
            ,imp_iva CHAR(2)
            ,monotributo CHAR(2)
            ,integrante_soc CHAR(1)
            ,empleador CHAR(1)
            ,act_monotributo CHAR(2)
        )
    )LOCATION(dp : 'padron.txt')
)REJECT LIMIT UNLIMITED;
