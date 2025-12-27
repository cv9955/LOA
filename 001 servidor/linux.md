# Sistema Operativo 

USB Booteable: Rufus v4.1

iso: [Rocky-8.8-x86_64-dvd1]

## Particiones de disco
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

### Directorios
/opt
/home

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
> ip 192.168.0.21


### Instalar Actualizaciones 
```
# dnf update
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
tutorial para configurar [firewall]

Abrir los puertos
```
# firewall-cmd --zone=public --add-port=1521/tcp
# firewall-cmd --zone=public --add-port=8080/tcp
# firewall-cmd --zone=public --add-port=8443/tcp
# firewall-cmd --runtime-to-permanent
```
Comprobar resultado
```
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
## JAVA JDK17
```
# curl -o jdk17.rpm https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
# yum install jdk17.rpm
```


### montar disco
```
# mount /dev/sdb1 /mnt/fra

# chown oracle:oinstall /mnt/fra


[oracle@rocky8 win]$ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda           8:0    0 111,8G  0 disk
├─sda1        8:1    0     1G  0 part /boot
└─sda2        8:2    0 110,8G  0 part
  ├─rl-root 253:0    0    70G  0 lvm  /
  ├─rl-swap 253:1    0   5,9G  0 lvm  [SWAP]
  └─rl-home 253:2    0    35G  0 lvm  /home
sdb           8:16   0 931,5G  0 disk
├─sdb1        8:17   0   200G  0 part
├─sdb2        8:18   0   200G  0 part
└─sdb3        8:19   0 531,5G  0 part



## fstab >> montar al arranque
sudo nano /etc/fstab
/dev/vdb1 /mnt/1 ext4 defaults 0 0

```


### montar DISCO NTFS
```
# yum install epel-release
# yum install ntfs-3g
```

```
# df -h
S.ficheros          Tamaño Usados  Disp Uso% Montado en
devtmpfs              5,7G      0  5,7G   0% /dev
tmpfs                 5,7G      0  5,7G   0% /dev/shm
tmpfs                 5,7G    18M  5,7G   1% /run
tmpfs                 5,7G      0  5,7G   0% /sys/fs/cgroup
/dev/mapper/rl-root    70G   7,2G   63G  11% /
/dev/mapper/rl-home    35G   296M   35G   1% /home
/dev/sda1            1014M   338M  677M  34% /boot
tmpfs                 1,2G    32K  1,2G   1% /run/user/1000

# mkdir /mnt/win

# mount -t ntfs-3g /dev/sda1 /mnt/win

umount /mnt/win
```


2. **Verificar UUID del disco** (más seguro que usar `/dev/sdc3` directamente):
   ```bash
   sudo blkid /dev/sdc3
   ```
   Ejemplo de salida:
   ```
   /dev/sdc3: UUID="1234-ABCD" TYPE="ntfs"
   ```

3. **Editar `/etc/fstab`**:
   ```bash
   sudo nano /etc/fstab
   ```
   Agregá una línea como esta (usando tu UUID real):

   ```
   UUID=1234-ABCD   /srv/samba/share   ntfs-3g   defaults,permissions   0   0
   ```

   - `ntfs-3g` → driver recomendado para NTFS en Linux.  
   - `defaults,permissions` → permite que Samba respete permisos de usuario/grupo.  
   - `/srv/samba/share` → punto de montaje que definiste antes.  

4. **Probar montaje sin reiniciar**:
   ```bash
   sudo mount -a
   ```
   Si no da error, quedó bien configurado.

---



## referencias

dnf search nombre_paquete

systemctl start nombre_servicio

useradd nombre_usuario

### Buscar Archivos en el disco
> find ./ 

### descargar archivo
```
curl -o apex.zip https://download.oracle.com/otn_software/apex/apex-latest.zip
```

### Descomprimir
```
unzip file.zip -d /dir
```
[Rocky-8.8-x86_64-dvd1]: https://docs.rockylinux.org/guides/8_6_installation/
[Firewall]: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-firewalld-on-centos

### ACTUALIZAR LINUX

sudo dnf check-update
sudo dnf update

