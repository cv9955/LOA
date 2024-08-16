## Apex 
  - Version 23.2

## UPGRADE   - Version 24.1 (ago 2024)
$ curl -o apex.zip https://download.oracle.com/otn_software/apex/apex-latest.zip
$ unzip apex.zip -d /opt/oracle
nota!! renombrar carpeta APEX de la version anterior >> mv APEX APEX23
y la carpeta META-INF ... 

```sql
CREATE TABLESPACE APEX24
DATAFILE '/opt/oracle/oradata/XE/#PDB_NAME#/apex24.dbf'
SIZE 300M AUTOEXTEND ON NEXT 50M MAXSIZE 1G;
```
> @apexins.sql APEX24 APEX24 APEX_TEMP /i/
> @apex_rest_config.sql;

ORDS ya esta configurado con la carpeta imegenes en /opt/oracle/apex/images.. 

#### fin de UPGRADE


### Descarga
```
$ curl -o apex.zip https://download.oracle.com/otn_software/apex/apex-latest.zip
$ unzip apex.zip -d /opt/oracle
```
nota!! renombrar carpeta APEX de la version anterior >> mv APEX APEX23
y la carpeta META-INF ... 

### Instalacion
```
/opt/oracle/apex $ sqlplus / as sysdba
```
```sql
alter session set container = #PDB_NAME#;
```
```sql
> select * from v$tablespace;

TS# NAME                           INC BIG FLA ENC     CON_ID
---------- ------------------------------ --- --- --- --- ----------
 0 SYSTEM                         YES NO  YES              3
 1 SYSAUX                         YES NO  YES              3
 2 UNDOTBS1                       YES NO  YES              3
 3 TEMP                           NO  NO  YES              3
 5 USERS                          YES NO  YES              3
```
```sql
> select file#,name from v$datafile;

/opt/oracle/oradata/ORCL/pdbloa/system01.dbf
/opt/oracle/oradata/ORCL/pdbloa/sysaux01.dbf
/opt/oracle/oradata/ORCL/pdbloa/undotbs01.dbf
/opt/oracle/oradata/ORCL/pdbloa/users01.dbf
```

### Crear tablespace
```sql
CREATE TABLESPACE APEX24
DATAFILE '/opt/oracle/oradata/XE/#PDB_NAME#/apex24.dbf'
SIZE 300M AUTOEXTEND ON NEXT 50M MAXSIZE 1G;
-- luego de la instalacion el archivo tenia 230M

-- SE USA LA MISMA APEX_TEMP
CREATE TEMPORARY TABLESPACE APEX_TEMP
TEMPFILE '/opt/oracle/oradata/XE/#PDB_NAME#/apex_temp.dbf'
SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE 1G;
```

### instalacion APEX 24.1
```
> @apexins.sql APEX24 APEX24 APEX_TEMP /i/
> @apex_rest_config.sql;


> @apxchpwd.sql
  CAV Ag?24

// esto no va mas > alter user APEX_PUBLIC_USER IDENTIFIED BY $$$$;



> alter user APEX_PUBLIC_USER ACCOUNT UNLOCK;

>> session cdb$root
> ALTER USER ANONYMOUS ACCOUNT UNLOCK;    
> EXEC DBMS_XDB.SETLISTENERLOCALACCESS(FALSE);
```

### evitar vencimiento Password usuarios
```
> ALTER PROFILE "DEFAULT" LIMIT PASSWORD_LIFE_TIME UNLIMITED; 
```

[Apex-latest]:https://download.oracle.com/otn_software/apex/apex-latest.zip



### Offline Tablespace Apex Old
alter tablespace apex23 offline;

-- error en pagina admin workspace
Error acessing Oracle Apex 23.1 after upgrade
ora-00376 file cannot be read at this time
$ curl -o apex_verify.sql https://support.oracle.com/epmos/main/downloadattachmentprocessor?attachid=2036107.1:APEX_POS_12C_SCRIPT&clickstream=no