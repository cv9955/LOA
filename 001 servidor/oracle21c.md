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
- global database name = ORCL
- SID = ORCL
- PDB = pdbloa
- listener = LISTENERXE
- Memoria SGA= 1536mb PGA= 512mb
- FRA = 
- SharedServers = 5

### Configurar Entorno
```
$ /etc/profile.d/cav.sh

export ORACLE_SID=ORCL
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=$ORACLE_BASE/product/21c/dbhomeXE
export PATH="$PATH:$ORACLE_HOME/bin:$ORACLE_BASE/ords/bin"
```
```
$ /etc/oratab
ORCL:/opt/oracle/product/21c/dbhomeXE:Y
```
```
$ oraenv

```

### Problemas
> no arranca al reiniciar el pc.. 
- el servicio esta ON
- sqlplus  idle estado
-  startup funcion pero el listener no lo toma
- oraenv [XE]


## Status
### carpeta dbs
```
/opt/oracle/dbs $ ls -l 
-rw-rw----. 1 oracle oinstall  1544 may 16 18:43 hc_XE.dat
-rw-r-----. 1 oracle oinstall  2198 may 16 16:54 init.ora
-rw-r-----. 1 oracle oinstall  2198 may 16 17:03 initXE.ora
-rw-r-----. 1 oracle oinstall  2048 may 13 19:52 orapwxe
-rw-r-----. 1 oracle oinstall 10752 may 16 19:20 spfileXE.ora
```
### initXE.ora
```
##############################################################################
# Copyright (c) 1991, 2013 by Oracle Corporation
##############################################################################

###########################################
# Cache and I/O
###########################################
db_block_size=8192

###########################################
# File Configuration
###########################################
control_files=("/opt/oracle/oradata/ORCL/control01.ctl", "/opt/oracle/oradata/ORCL/control02.ctl")

###########################################
# Cursors and Library Cache
###########################################
open_cursors=300

###########################################
# Database Identification
###########################################
db_name="orcl"

###########################################
# SGA Memory
###########################################
sga_target=1536m

###########################################
# NLS
###########################################
nls_language="SPANISH"
nls_territory="SPAIN"

###########################################
# Miscellaneous
###########################################
compatible=21.0.0
diagnostic_dest=/opt/oracle
enable_pluggable_database=true

###########################################
# Processes and Sessions
###########################################
processes=320

###########################################
# Network Registration
###########################################
local_listener=LISTENER_XE

###########################################
# System Managed Undo and Rollback Segments
###########################################
undo_tablespace=UNDOTBS1

###########################################
# Security and Auditing
###########################################
audit_file_dest="/opt/oracle/admin/orcl/adump"
audit_trail=db
remote_login_passwordfile=EXCLUSIVE

###########################################
# Shared Server
###########################################
dispatchers="(PROTOCOL=TCP)"
shared_servers=5

###########################################
# Sort, Hash Joins, Bitmap Indexes
###########################################
pga_aggregate_target=512m
```

### SPFILE



### Referencias
[Oracle21c-preinstall]: https://yum.oracle.com/repo/OracleLinux/OL8/appstream/x86_64/getPackage/oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm 
[Oracle21c]: oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm