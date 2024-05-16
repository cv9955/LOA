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
TODO: IP FIJA
ABRIR PUERTOS EN FIREWALL
ABRIR PUERTOS EN ROUTER





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
# systemctl status firewalld

# firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp3s0
  sources:
  services: cockpit dhcpv6-client ssh
  ports:
  protocols:
  forward: no
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:

# firewall-cmd --get-zones
block dmz drop external home internal libvirt nm-shared public trusted work

# firewall-cmd --zone=work --list-all
work
  target: default
  icmp-block-inversion: no
  interfaces:
  sources:
  services: cockpit dhcpv6-client ssh
  ports:
  protocols:
  forward: no
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:

# firewall-cmd --zone=home --list-all
home
  target: default
  icmp-block-inversion: no
  interfaces:
  sources:
  services: cockpit dhcpv6-client mdns samba-client ssh
  ports:
  protocols:
  forward: no
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:

# firewall-cmd --set-default-zone work

# firewall-cmd --zone=public --add-service=samba-client --permanent

# firewall-cmd --runtime-to-permanent
```

### NTFS
```
# yum install epel-release
# yum install ntfs-3g

mkdir /mnt/win

mount -t ntfs-3g /dev/sdb1 /mnt/win

umount /mnt/win
```
TODO : 

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
export PATH="$PATH:$ORACLE_HOME/bin"
```


### Arranque de la BD
```
$ /etc/oratab
XE:/opt/oracle/product/21c/dbhomeXE:Y
```

### SPFILE
```
$ /opt/oracle/dbs/initXE.ora
SPFILE='/opt/oracle/dbs/spfilexe.ora'

[oracle@rocky8 cav]$ cat /opt/oracle/dbs/spfilexe.ora
C"▒t▒▒Q▒ECC"wxe.__data_transfer_cache_size=0
XE.__data_transfer_cache_size=0
xe.__db_cache_size=1073741824
XE.__db_cache_size=1124073472
xe.__inmemory_ext_roarea=0
XE.__inmemory_ext_roarea=0
xe.__inmemory_ext_rwarea=0
XE.__inmemory_ext_rwarea=0
xe.__java_pool_size=0
XE.__java_pool_size=0
xe.__large_pool_size=16777216
XE.__large_pool_size=16777216
xe.__oracle_base='/opt/oracle'#ORACLE_BASE set from environment
XE.__oracle_base='/opt/oracle'#ORACLE_BASE set from environment
xe.__pga_aggregate_targeCC"t=536870912
XE.__pga_aggregate_target=536870912
xe.__sga_target=1610612736
XE.__sga_target=1610612736
xe.__shared_io_pool_size=83886080
XE.__shared_io_pool_size=83886080
xe.__shared_pool_size=385875968
XE.__shared_pool_size=369098752
xe.__streams_pool_size=33554432
XE.__streams_pool_size=0
xe.__unified_pga_pool_size=0
XE.__unified_pga_pool_size=0
*.audit_file_dest='/opt/oracle/admin/orcl/adump'
*.audit_trail='db'
*.compatible='21.0.0'
*.control_files='/opt/oracle/oradata/ORCL/controlCC"    |01.ctl','/opt/oracle/oradata/ORCL/control02.ctl'
*.db_block_size=8192
*.db_name='orcl'
*.diagnostic_dest='/opt/oracle'
*.dispatchers='(PROTOCOL=TCP)'
*.enable_pluggable_database=true
*.local_listener='LISTENER_XE'
*.nls_language='SPANISH'
*.nls_territory='SPAIN'
*.open_cursors=300
*.pga_aggregate_target=512m
*.processes=320
*.remote_login_passwordfile='EXCLUSIVE'
*.sga_target=1536m
*.shared_servers=5
*.undo_tablespace='UNDOTBS1'
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

## Firewall
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







[Rocky8]: https://docs.rockylinux.org/guides/8_6_installation/
[Oracle21c-preinstall]: https://yum.oracle.com/repo/OracleLinux/OL8/appstream/x86_64/getPackage/oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm 
[Oracle21c]: oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
[Firewall]: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-firewalld-on-centos