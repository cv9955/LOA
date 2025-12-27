## Particiones de disco

-  sda
  - sda1 :: 
    - /boot :  1.0 G
  - sda2
    - /root : 240.0 G
    - swap  :  5.9 G
    - /home : 200.0 G
- sdb
  - sdb1
    - /fra : 900 G


[root@localhost cav]# df -h
S.ficheros           Tamaño Usados  Disp Uso% Montado en
devtmpfs               3,7G      0  3,7G   0% /dev
tmpfs                  3,8G      0  3,8G   0% /dev/shm
tmpfs                  3,8G    18M  3,8G   1% /run
tmpfs                  3,8G      0  3,8G   0% /sys/fs/cgroup
/dev/mapper/rl-root    240G   8,3G  232G   4% /
/dev/sda1             1014M   306M  709M  31% /boot
/dev/mapper/rl-home    200G   1,6G  199G   1% /home
/dev/mapper/rl00-fra   707G   5,0G  702G   1% /fra
tmpfs                  766M    44K  766M   1% /run/user/1000


## Nombre de RED
rocky8.helguera

## Configuracion
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
se habilito desde el icono de inicio
> ip 192.168.0.135

### Instalar Actualizaciones 
```
# dnf upgrade -y
```
### SELINUX
> no arraca el servicio ORDS
```
/etc/selinux # getenforce
/etc/selinux # setenforce Permissive
/etc/selinux # nano config 
```


### Servicios 
#### Cockpit - Terminal web para administrador - puerto 9090
``` 
# dnf install cockpit
# systemctl enable --now cockpit.socket
# firewall-cmd --permanent --zone=public --add-service=cockpit
# firewall-cmd --reload
```

### Firewall
```
[root@rocky8 transparent_hugepage]# firewall-cmd --permanent --zone=public --add-service=cockpit
Warning: ALREADY_ENABLED: cockpit
success
[root@rocky8 transparent_hugepage]# firewall-cmd --reload
success
[root@rocky8 transparent_hugepage]# firewall-cmd --zone=public --add-port=1521/tcp
success
[root@rocky8 transparent_hugepage]# firewall-cmd --zone=public --add-port=8080/tcp
success
[root@rocky8 transparent_hugepage]# firewall-cmd --zone=public --add-port=8443/tcp
success
[root@rocky8 transparent_hugepage]# firewall-cmd --runtime-to-permanent
success
[root@rocky8 transparent_hugepage]# firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp2s0
  sources:
  services: cockpit dhcpv6-client ssh
  ports: 1521/tcp 8080/tcp 8443/tcp
  protocols:
  forward: no
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:


