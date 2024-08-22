# DATABASE
> Este archivo documenta la configuracion y el mantenimiento periodico de la base de datos


## PDBS - pluggable databases
> 
```
SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDBLOA                         READ WRITE NO
```

## USUARIOS
[create_users](create_users.sql)

```SQL
select * from dba_users
where account_status = 'OPEN';

- SYS	0
- SYSTEM	9
- ANONYMOUS	71
- ORDS_PUBLIC_USER	115
- ORDS_METADATA	116
- SYSRAC	2147483620
- PDBADMIN	108
- APEX_PUBLIC_USER	111

```


## TABLESPACES

## ARCHIVELOGS




## Copia Pdb de PTC
CREATE PLUGGABLE DATABASE pdbPTC USING '/opt/oracle/oradata/XE/XEPDB1/XEPDB1.xml' 
  SOURCE_FILE_DIRECTORY = '/opt/oracle/oradata/XE/XEPDB1/'  
  MOVE
  FILE_NAME_CONVERT = ('/opt/oracle/oradata/XE/XEPDB1/', '/opt/oracle/oradata/XE/PDBPTC/')
  STORAGE (MAXSIZE 8G);
