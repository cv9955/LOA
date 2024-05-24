# Servidor Oracle 21c
> info sacada del curso Udemy !!

## Preinstalador
descargo : [Oracle21c-preinstall]
```
# curl -o oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm https://yum.oracle.com/repo/OracleLinux/OL8/appstream/x86_64/getPackage/oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm 

# yum install -y oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm
```



Parametros del Kernel modificados por el pre install
```
# vi /etc/sysctl.conf

fs.file-max = 6815744
kernel.sem = 250 32000 100 128
kernel.shmmni = 4096
kernel.shmall = 1073741824
kernel.shmmax = 4398046511104
kernel.panic_on_oops = 1
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500
```

Grupos creados
```
$ cat /etc/group
cav:x:1000:
oinstall:x:54321:oracle
dba:x:54322:oracle
oper:x:54323:oracle
backupdba:x:54324:oracle
dgdba:x:54325:oracle
kmdba:x:54326:oracle
racdba:x:54330:oracle
```
Usuarios creados
```
$ cat /etc/passwd
cav:x:1000:1000:Cesar Villalba:/home/cav:/bin/bash
oracle:x:54321:54321::/home/oracle:/bin/bash
```

### Password
```
# passwd oracle
```


## Instalacion
link descarga:  [Oracle21c]
```
# yum install oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
```

### DBCA - Crear Base de Datos
```
[oracle@rocky8 bin]$ ./dbca
```
- Instacia Unica - XE Database
- global database name = XE
- SID = XE
- PDB = pdbloa
- listener = LISTENERXE
- Memoria SGA= 1536mb PGA= 512mb
- FRA = 
- SharedServers = 5

### Configurar Entorno
```
$ /etc/profile.d/cav.sh

export ORACLE_SID=XE
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=$ORACLE_BASE/product/21c/dbhomeXE
export PATH="$PATH:$ORACLE_HOME/bin:$ORACLE_BASE/ords/bin"
```
```
$ /etc/oratab
XE:/opt/oracle/product/21c/dbhomeXE:Y
$ oraenv
```
 
### Auto-Start


```
systemctl start oracle-xe-21c
### este comando no funciono ### systemctl enable oracle-xe-21c
sudo /usr/lib/systemd/systemd-sysv-install enable oracle-xe-21c
```


## SQLPLUS
```
$ sqlplus / as sysdba

SQL> startup;
ORACLE instance started.

Total System Global Area 1610612120 bytes
Fixed Size                  9686424 bytes
Variable Size             436207616 bytes
Database Buffers         1157627904 bytes
Redo Buffers                7090176 bytes
Base de datos montada.
Base de datos abierta.

SQL> show pdbs

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDBLOA                         MOUNTED

SQL> alter session set container=pdbloa;
Sesion modificada.

SQL> startup
Base de datos de conexion abierta.
```

### PDBLOA auto start
```
SYS@XE >startup
ORACLE instance started.

Total System Global Area 1610612120 bytes
Fixed Size                  9686424 bytes
Variable Size             385875968 bytes
Database Buffers         1207959552 bytes
Redo Buffers                7090176 bytes
Base de datos montada.
Base de datos abierta.
SYS@XE >show pdbs

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDBLOA                         MOUNTED
SYS@XE >alter pluggable database pdbloa open;

Base de datos de conexion modificada.

SYS@XE >alter pluggable database pdbloa save state;

Base de datos de conexion modificada.
```

## listener
```
[oracle@rocky8 admin]$ lsnrctl reload

LSNRCTL for Linux: Version 21.0.0.0.0 - Production on 24-MAY-2024 00:14:16

Copyright (c) 1991, 2021, Oracle.  All rights reserved.

Connecting to (ADDRESS=(PROTOCOL=tcp)(HOST=)(PORT=1521))
The command completed successfully
```
```
[oracle@rocky8 admin]$ lsnrctl status

LSNRCTL for Linux: Version 21.0.0.0.0 - Production on 24-MAY-2024 00:14:21

Copyright (c) 1991, 2021, Oracle.  All rights reserved.

Connecting to (ADDRESS=(PROTOCOL=tcp)(HOST=)(PORT=1521))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 21.0.0.0.0 - Production
Start Date                24-MAY-2024 00:11:23
Uptime                    0 days 0 hr. 2 min. 57 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /opt/oracle/homes/OraDBHome21cXE/network/admin/listener.ora
Listener Log File         /opt/oracle/diag/tnslsnr/rocky8/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=rocky8.loagrafica)(PORT=1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=rocky8.loagrafica)(PORT=5500))(Security=(my_wallet_directory=/opt/oracle/admin/XE/xdb_wallet))(Presentation=HTTP)(Session=RAW))
Services Summary...
Service "192b020f75761809e065325a3a52b6a5" has 1 instance(s).
  Instance "XE", status READY, has 2 handler(s) for this service...
Service "XE" has 1 instance(s).
  Instance "XE", status READY, has 2 handler(s) for this service...
Service "pdbloa" has 1 instance(s).
  Instance "XE", status READY, has 2 handler(s) for this service...
The command completed successfully
```
### listener.ora
```
[oracle@rocky8 admin]$ cat listener.ora
# listener.ora Network Configuration File: /opt/oracle/homes/OraDBHome21cXE/network/admin/listener.ora
# Generated by Oracle configuration tools.

LISTENERXE =
  (DESCRIPTION_LIST =
    (DESCRIPTION =
#     (ADDRESS = (PROTOCOL = TCP)(HOST = rocky8.fibertel.com.ar)(PORT = 1521))
      (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.0.21)(PORT = 1521))
      (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1521))
    )
  )
```
### sqlnet.ora
```
[oracle@rocky8 admin]$ cat sqlnet.ora
# sqlnet.ora Network Configuration File: /opt/oracle/homes/OraDBHome21cXE/network/admin/sqlnet.ora
# Generated by Oracle configuration tools.

NAMES.DIRECTORY_PATH= (TNSNAMES, ONAMES, HOSTNAME)
```
### tnsnames.ora
```
[oracle@rocky8 admin]$ cat tnsnames.ora
# tnsnames.ora Network Configuration File: /opt/oracle/homes/OraDBHome21cXE/network/admin/tnsnames.ora
# Generated by Oracle configuration tools.

LISTENER_XE =
  (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.0.21)(PORT = 1521))

XE =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.0.21)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = SHARED)
      (SERVICE_NAME = XE)
    )
  )

```





### Referencias
[Oracle21c-preinstall]: https://yum.oracle.com/repo/OracleLinux/OL8/appstream/x86_64/getPackage/oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm 
[Oracle21c]: oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm

[instalacion](https://oracle-base.com/articles/21c/oracle-db-21c-xe-rpm-installation-on-oracle-linux-7-and-8#auto-start)
