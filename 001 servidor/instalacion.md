# Instalacion del servidor

## Sistema Operativo 

USB Booteable: Rufus v4.1
iso: Rocky-8.8-x86_64-dvd1
[Rocky8]

Particiones
### DISCO 1 - SDD 120G 
-  sda
  - sda1 :: 
    - /boot :  1.0 G
  - sda2
    - /root : 70.0 G
    - swap  :  5.9 G
    - /home : 35.0 G

### DISCO 2 - HDD 1000G
/fra : 240.0 G  -- BACKUP RMAN
/loa : 240.0 G  -- CARPETAS COMPARTIDAS
/??? : 240.0 G  -- ANEXOS AL SISTEMA
/??? : 240.0 G  -- DISPONIBLE

Directorios
/opt
/home


### Desactivación de hugepages transparentes
THP está habilitado por defecto en Red Hat Enterprise Linux 8. 

Compruebe el estado actual del THP:
```
# cat /sys/kernel/mm/transparent_hugepage/enabled
```
Desactivar el THP:
```
# echo never > /sys/kernel/mm/transparent_hugepage/enabled
```

### Habilitar Conecciones LAN
> se habilito desde el icono de inicio
> ip 192.168.0.21


### Instalar Actualizaciones 
```
# dnf update
```

### Activar Servicios 
#### Cockpit - Terminal web para administrador - puerto 9090
``` 
# dnf install cockpit
# systemctl enable --now cockpit.socket
# firewall-cmd --permanent --zone=public --add-service=cockpit
# firewall-cmd --reload
```
### Firewall
[Firewall]
```
# firewall-cmd --zone=public --add-port=1521/tcp
success
# firewall-cmd --zone=public --add-port=8080/tcp
success
# firewall-cmd --runtime-to-permanent
success
# firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp3s0
  sources:
  services: cockpit dhcpv6-client ssh
  ports: 1521/tcp 8080/tcp
  protocols:
  forward: no
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
```
### NTFS
```
# yum install epel-release
# yum install ntfs-3g

mkdir /mnt/win

mount -t ntfs-3g /dev/sdb1 /mnt/win

umount /mnt/win
```


## Servidor Oracle 21c
> info sacada del curso Udemy !!
### Preinstalador
[Oracle21c-preinstall]
```
# curl -o oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm https://yum.oracle.com/repo/OracleLinux/OL8/appstream/x86_64/getPackage/oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm 

# yum install -y oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm
```

```
Parametros del Kernel modificados por el pre install
# vi /etc/sysctl.conf

# sysctl settings are defined through files in
# /usr/lib/sysctl.d/, /run/sysctl.d/, and /etc/sysctl.d/.
#
# Vendors settings live in /usr/lib/sysctl.d/.
# To override a whole file, create a new file with the same in
# /etc/sysctl.d/ and put new settings there. To override
# only specific settings, add a file with a lexically later
# name in /etc/sysctl.d/ and put new settings there.
#
# For more information, see sysctl.conf(5) and sysctl.d(5).

# oracle-database-preinstall-21c setting for fs.file-max is 6815744
fs.file-max = 6815744

# oracle-database-preinstall-21c setting for kernel.sem is '250 32000 100 128'
kernel.sem = 250 32000 100 128

# oracle-database-preinstall-21c setting for kernel.shmmni is 4096
kernel.shmmni = 4096

# oracle-database-preinstall-21c setting for kernel.shmall is 1073741824 on x86_64
kernel.shmall = 1073741824

# oracle-database-preinstall-21c setting for kernel.shmmax is 4398046511104 on x86_64
kernel.shmmax = 4398046511104

# oracle-database-preinstall-21c setting for kernel.panic_on_oops is 1 per Orabug 19212317
kernel.panic_on_oops = 1

# oracle-database-preinstall-21c setting for net.core.rmem_default is 262144
net.core.rmem_default = 262144

# oracle-database-preinstall-21c setting for net.core.rmem_max is 4194304
net.core.rmem_max = 4194304

# oracle-database-preinstall-21c setting for net.core.wmem_default is 262144
net.core.wmem_default = 262144

# oracle-database-preinstall-21c setting for net.core.wmem_max is 1048576
net.core.wmem_max = 1048576

# oracle-database-preinstall-21c setting for net.ipv4.conf.all.rp_filter is 2
net.ipv4.conf.all.rp_filter = 2

# oracle-database-preinstall-21c setting for net.ipv4.conf.default.rp_filter is 2
net.ipv4.conf.default.rp_filter = 2

# oracle-database-preinstall-21c setting for fs.aio-max-nr is 1048576
fs.aio-max-nr = 1048576

# oracle-database-preinstall-21c setting for net.ipv4.ip_local_port_range is 9000 65500
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


### Instalacion
[Oracle21c]
```
# yum install oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
```

### DBCA - Crear Base de Datos
```
[oracle@rocky8 bin]$ ./dbca
```
Instacia Unica - XE Database
global database name = XE
SID = XE
PDB = pdbloa
listener = LISTENERXE
Memoria SGA= 1536mb PGA= 512mb
FRA = 
SharedServers = 5

## Configuracion

### Configurando Shell
```
$ /etc/profile.d/cav.sh
export ORACLE_SID=XE
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=$ORACLE_BASE/product/21c/dbhomeXE
export PATH="$PATH:$ORACLE_HOME/bin:$ORACLE_BASE/ords/bin"
```


### Arranque de la BD
```
$ /etc/oratab
XE:/opt/oracle/product/21c/dbhomeXE:Y
```

### carpeta dbs
/opt/oracle/dbs $ ls -l 
-rw-rw----. 1 oracle oinstall  1544 may 16 18:43 hc_XE.dat
-rw-r-----. 1 oracle oinstall  2198 may 16 16:54 init.ora
-rw-r-----. 1 oracle oinstall  2198 may 16 17:03 initXE.ora
-rw-r-----. 1 oracle oinstall  2048 may 13 19:52 orapwxe
-rw-r-----. 1 oracle oinstall 10752 may 16 19:20 spfileXE.ora

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
```
$ /opt/oracle/dbs/initXE.ora
SPFILE='/opt/oracle/dbs/spfilexe.ora'

[oracle@rocky8 cav]$ cat /opt/oracle/dbs/spfileXE.ora
C"▒▒RuȯECC"#fXE.__data_transfer_cache_size=0
XE.__db_cache_size=1107296256
XE.__inmemory_ext_roarea=0
XE.__inmemory_ext_rwarea=0
XE.__java_pool_size=0
XE.__large_pool_size=16777216
XE.__pga_aggregate_target=536870912
XE.__sga_target=1610612736
XE.__shared_io_pool_size=83886080
XE.__shared_pool_size=385875968
XE.__streams_pool_size=0
XE.__unified_pga_pool_size=0
*._always_anti_join='CHOOSE'
*._always_semi_join='CHOOSE'
*.audit_file_dest='/opt/oracle/admin/orcl/adump'
*.audit_trail='DB'
*._bloom_seCC"=Irial_filter='ON'
*._b_tree_bitmap_plans=TRUE
*.compatible='21.0.0'
*._complex_view_merging=TRUE
*._compression_compatibility='21.0.0'
*.connection_brokers='((TYPE=DEDICATED)(BROKERS=1))','((TYPE=EMON)(BROKERS=1))'# connection_brokers default value
*.control_files='/opt/oracle/oradata/ORCL/control01.ctl','/opt/oracle/oradata/ORCL/control02.ctl'
*.control_management_pack_access='NONE'# change default to NONE when system is not EE
*.core_dump_dest='/opt/oracle/diag/rdbms/orcl/XE/cdump'
CC*.__data_transfer_cache_size=0
*.db_block_size=8192
*.__db_cache_size=1072M
*.db_name='orcl'
*._diag_adr_trace_dest='/opt/oracle/diag/rdbms/orcl/XE/trace'
*.diagnostic_dest='/opt/oracle'
*.dispatchers='(PROTOCOL=TCP)'
*._ds_xt_split_count=1
*._eliminate_common_subexpr=TRUE
*.enable_pluggable_database=TRUE
*._fast_full_scan_enabled=TRUE
*._generalized_pruning_enabled=TRUE
*._gs_anti_semi_join_allowed=TRUE
*._hang_resolution_scope='INSTANCE'# _hang_resolution_scope updated by kjznpahpsCC"Z
*._improved_outerjoin_card=TRUE
*._improved_row_length_enabled=TRUE
*._index_join_enabled=TRUE
*.__inmemory_ext_roarea=0
*.__inmemory_ext_rwarea=0
*.__java_pool_size=0
*.job_queue_processes=80# job queue processes default tuning
*._key_vector_create_pushdown_threshold=20000
*._ksb_restart_policy_times='0','60','120','240'# internal update to set default
*.__large_pool_size=16M
*._left_nested_loops_random=TRUE
*.local_listener='LISTENER_XE'
*.log_buffer=6616K# log buffer update
*._mvCC"cw_access_compute_fresh_data='ON'
*._new_initial_join_orders=TRUE
*._new_sort_cost_estimate=TRUE
*._nlj_batching_enabled=1
*.nls_language='SPANISH'
*.nls_territory='SPAIN'
*.open_cursors=300
*._optim_enhance_nnull_detection=TRUE
*._optimizer_ads_use_partial_results=TRUE
*._optimizer_better_inlist_costing='ALL'
*._optimizer_cbqt_or_expansion='ON'
*._optimizer_cluster_by_rowid_control=129
*._optimizer_control_shard_qry_processing=65472
*._optimizer_cost_based_transformation='LINEAR'
*._oCC"zTptimizer_cost_model='CHOOSE'
*._optimizer_extended_cursor_sharing='UDO'
*._optimizer_extended_cursor_sharing_rel='SIMPLE'
*._optimizer_extended_stats_usage_control=192
*._optimizer_join_order_control=3
*._optimizer_max_permutations=2000
*.optimizer_mode='ALL_ROWS'
*._optimizer_mode_force=TRUE
*._optimizer_native_full_outer_join='FORCE'
*._optimizer_or_expansion='DEPTH'
*._optimizer_proc_rate_level='BASIC'
*._optimizer_system_stats_usage=TRUE
*._optimizer_try_st_before_jppd=TRUE
*._opCChtimizer_use_cbqt_star_transformation=TRUE
*._optim_peek_user_binds=TRUE
*.__oracle_base='/opt/oracle'# ORACLE_BASE set from environment
*._ordered_nested_loop=TRUE
*._or_expand_nvl_predicate=TRUE
*._parallel_broadcast_enabled=TRUE
*.parallel_min_servers=1# kxfpnfy update parallel_min_servers
*.__pga_aggregate_target=512M
*.pga_aggregate_target=512M
*._pivot_implementation_method='CHOOSE'
*.plsql_warnings='DISABLE:ALL'# PL/SQL warnings at init.ora
*._pred_move_around=TRUE
*.processes=CC" Mz320
*._push_join_predicate=TRUE
*._push_join_union_view=TRUE
*._push_join_union_view2=TRUE
*._px_adaptive_dist_nij_enabled='ON'
*._px_dist_agg_partial_rollup_pushdown='ADAPTIVE'
*._px_groupby_pushdown='FORCE'
*._px_partial_rollup_pushdown='ADAPTIVE'
*._px_shared_hash_join=FALSE
*._px_wif_dfo_declumping='CHOOSE'
*.query_rewrite_enabled='TRUE'
*.__reload_lsnr='0'# lreg reload listener
*.remote_login_passwordfile='EXCLUSIVE'
*._result_cache_latch_count=4
*.result_cache_max_size=8M
*.resCC"
@Wult_cache_max_temp_size=80M
*.__sga_target=1536M
*.sga_target=1536M
*.__shared_io_pool_size=80M
*.__shared_pool_size=352M
*.shared_servers=5
*._sql_model_unfold_forloops='RUN_TIME'
*._sqltune_category_parsed='DEFAULT'# parsed sqltune_category
*.__streams_pool_size=0
*._subquery_pruning_mv_enabled=FALSE
*._table_scan_cost_plus_one=TRUE
*.undo_tablespace='UNDOTBS1'
*.__unified_pga_pool_size=0
*._union_rewrite_for_gs='YES_GSET_MVS'
*._unnest_subquery=TRUE
*._use_column_stats_for_functioCC"
                                  Cn=TRUE
*._xt_sampling_scan_granules='ON'
CC"
NeCC"MeCC"LeCC"SeCC"ReCC"QeCC"PeCC"WeCC"VeC
```


## Listener
```
[oracle@rocky8 admin]$ lsnrctl status

LSNRCTL for Linux: Version 21.0.0.0.0 - Production on 16-MAY-2024 11:17:02

Copyright (c) 1991, 2021, Oracle.  All rights reserved.

Connecting to (ADDRESS=(PROTOCOL=tcp)(HOST=)(PORT=1521))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 21.0.0.0.0 - Production
Start Date                16-MAY-2024 11:16:00
Uptime                    0 days 0 hr. 1 min. 2 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /opt/oracle/homes/OraDBHome21cXE/network/admin/listener.ora
Listener Log File         /opt/oracle/diag/tnslsnr/rocky8/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=rocky8.loa)(PORT=1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=rocky8.loa)(PORT=5500))(Security=(my_wallet_directory=/opt/oracle/admin/orcl/xdb_wallet))(Presentation=HTTP)(Session=RAW))
Services Summary...
Service "185ed06f0e56e8bee065325a3a52b6a5" has 1 instance(s).
  Instance "XE", status READY, has 2 handler(s) for this service...
Service "c9ca595151886696e0532783e80aa7bc" has 1 instance(s).
  Instance "XE", status READY, has 2 handler(s) for this service...
Service "orcl" has 1 instance(s).
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



## Oracle XE auto start
> no arranca al reiniciar el pc.. el servicio esta ON
> sqlplus  idle estado
> startup funcion pero el listener no lo toma
> oraenv [XE]
> /etc/oratab XE:/opt/oracle/product/21c/dbhomeXE:Y
> 
> no entiendo por que no arranca todavia


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

## Apex 23.2
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
alter session set container = pdbloa;
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

> select file#,name from v$datafile;

9 /opt/oracle/oradata/ORCL/pdbloa/system01.dbf
10 /opt/oracle/oradata/ORCL/pdbloa/sysaux01.dbf
11 /opt/oracle/oradata/ORCL/pdbloa/undotbs01.dbf                                                                                                  
12 /opt/oracle/oradata/ORCL/pdbloa/users01.dbf
```

### Crear tablespace
```sql
CREATE TABLESPACE APEX
DATAFILE '/opt/oracle/oradata/ORCL/pdbloa/apex.dbf'
SIZE 300M AUTOEXTEND ON NEXT 50M MAXSIZE 1G;
-- luego de la instalacion el archivo tenia 230M

CREATE TEMPORARY TABLESPACE APEX_TEMP
TEMPFILE '/opt/oracle/oradata/ORCL/pdbloa/apex_temp.dbf'
SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE 1G;
```

### instalacion APEX 23.2
```
> @apexins.sql APEX APEX APEX_TEMP /i/

> @apxchpwd.sql
  CAV Ag?24

> alter user APEX_PUBLIC_USER ACCOUNT UNLOCK;
> alter user APEX_PUBLIC_USER IDENTIFIED BY $$$$;

> @apex_rest_config.sql;

> ALTER USER ANONYMOUS ACCOUNT UNLOCK;    >> session cdb$root
> EXEC DBMS_XDB.SETLISTENERLOCALACCESS(FALSE);

```
## JAVA JDK17
```
# curl -o jdk17.rpm https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
# yum install jdk17.rpm
```

## ORDS 24.11
### Descarga
```
[oracle@rocky8 ~]$ curl -o ords.zip https://download.oracle.com/otn_software/java/ords/ords-latest.zip
```
### unzip
```
[oracle@rocky8 ~]$ unzip ords.zip -d /opt/oracle/ords
```
### copia carpeta IMAGES
```
[oracle@rocky8 ~]$ cp -r /opt/oracle/apex/images /opt/oracle/ords
```
### install
```
# cd /opt/oracle/ords
# java -jar ords.war --config /opt/oracle/ords install 
```

### Servicio ords 
> Creo un servicio para que inicie al arrancar la pc
> crea el archivo de configuracion */etc/systemd/system/ords.service*
```
sudo systemctl edit --force ords.service
```
> Copio el siguiente texto
``` 
#creado by CAV

[Unit]
Description=ORDS Service

[Service]
User=oracle
WorkingDirectory=/opt/oracle/ords
SyslogIdentifier=ords
Restart=always
RestartSec=30
TimeoutStartSec=30
TimeoutStopSec=30

ExecStart=/usr/bin/java "-Dorg.eclipse.jetty.server.Request.maxFormContentSize=3000000" -jar ords.war serve
# standalone

ExecStop=kill $(ps -ef | grep "ords.war" | grep -v grep| awk '{print $2}')

[Install]
WantedBy=multi-user.target
```
> Activo el servicio
```
# systemctl enable --now ords.service

# systemctl status ords.service

# journalctl -u ords.service -f
```



## Problemas resueltos
### SELINUX
> no arraca el servicio ORDS
```
/etc/selinux # getenforce
/etc/selinux # setenforce Permissive
/etc/selinux # nano config 

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=permissive
# SELINUXTYPE= can take one of these three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted

```

### nombre de la BD y el ORACLE_SID
> puse nombre db= orcl y SID = XE, algo no funciona bien

### error al instalar ORDS
> se complico al usar usuario system.. tuve que generar el archivo de claves */opt/oracle/dbs/hc_XE.dat* ingresando nueva clave para sys con *orapwd*
```
/opt/oracle/dbs # orapwd file=$ORACLE_HOME/dbs/orapw$ORACLE_SID entries=5 force=y
```
> luego eliminar del pdb los usuarios ORDS_METADATA y ORDS_PUBLIC_USER
```sql
> drop user ORDS_METADATA cascade;
> drop user ORDS_PUBLIC_USER cascade; 
```
> borrar las carpetas de configuracion */opt/oracle/ords/databases*  y */opt/oracle/ords/global* 
> reinicio la intalacion de ORDS con usuario administrador *SYS*

## referencias
[Rocky8]: https://docs.rockylinux.org/guides/8_6_installation/
[Oracle21c-preinstall]: https://yum.oracle.com/repo/OracleLinux/OL8/appstream/x86_64/getPackage/oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm 
[Oracle21c]: oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
[Firewall]: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-firewalld-on-centos
[Apex]:https://download.oracle.com/otn_software/apex/apex-latest.zip
[Ords]:https://download.oracle.com/otn_software/java/ords/ords-latest.zip
[jdk17]:https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
