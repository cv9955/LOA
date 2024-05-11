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



TODO : 

## Servidor Oracle 21c

### Preinstalador
[Oracle21c-preinstall]
```
dnf install oracle-database-preinstall-21c
```

Parametros Kernel
```
# sudo sysctl -p
```

Limits Usuario

### Instalacion
[Oracle21c]
```
# yum install oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
```




[Rocky8]: https://docs.rockylinux.org/guides/8_6_installation/
[Oracle21c-preinstall]: https://yum.oracle.com/repo/OracleLinux/OL8/appstream/x86_64/getPackage/oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm 
[Oracle21c]: oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm