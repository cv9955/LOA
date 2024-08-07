## Apex 
  - Version 23.2
  - Version 24.1 (ago 2024)
### Descarga
```
$ curl -o apex.zip https://download.oracle.com/otn_software/apex/apex-latest.zip
$ unzip apex.zip -d /opt/oracle
```
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
CREATE TABLESPACE APEX23
DATAFILE '/opt/oracle/oradata/XE/#PDB_NAME#/apex.dbf'
SIZE 300M AUTOEXTEND ON NEXT 50M MAXSIZE 1G;
-- luego de la instalacion el archivo tenia 230M

CREATE TEMPORARY TABLESPACE APEX_TEMP
TEMPFILE '/opt/oracle/oradata/XE/#PDB_NAME#/apex_temp.dbf'
SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE 1G;
```

### instalacion APEX 23.2
```
> @apexins.sql APEX23 APEX23 APEX_TEMP /i/

> @apxchpwd.sql
  CAV Ag?24

// esto no va mas > alter user APEX_PUBLIC_USER IDENTIFIED BY $$$$;

> @apex_rest_config.sql;

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