# Discos

## [oracle@rocky8-victoriacor-com-ar ~]$ df -h
S.ficheros               Tamaño Usados  Disp Uso% Montado en
devtmpfs                   3,5G      0  3,5G   0% /dev
tmpfs                      3,5G      0  3,5G   0% /dev/shm
tmpfs                      3,5G    26M  3,5G   1% /run
tmpfs                      3,5G      0  3,5G   0% /sys/fs/cgroup
/dev/mapper/rl-root        559G    62G  497G  11% /
/dev/sda1                 1014M   588M  427M  58% /boot
/dev/sdb1                  458G    96G  339G  22% /mnt/fra
/dev/mapper/rl-home--new   145G   5,2G  140G   4% /home
tmpfs                      713M      0  713M   0% /run/user/54321
tmpfs                      713M    28K  713M   1% /run/user/1000




## [CAV@rocky8-victoriacor-com-ar oracle]$ lsblk
NAME             MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda                8:0    0 223,6G  0 disk
├─sda1             8:1    0     1G  0 part /boot
└─sda2             8:2    0 222,6G  0 part
  ├─rl-root      253:0    0 558,2G  0 lvm  /
  └─rl-swap      253:1    0   7,3G  0 lvm  [SWAP]
sdb                8:16   0 465,8G  0 disk
└─sdb1             8:17   0 465,8G  0 part /mnt/fra
sdc                8:32   0 931,5G  0 disk
├─sdc1             8:33   0   350M  0 part
├─sdc2             8:34   0   488G  0 part
│ ├─rl-root      253:0    0 558,2G  0 lvm  /
│ └─rl-home--new 253:2    0   145G  0 lvm  /home
└─sdc3             8:35   0 443,2G  0 part

## [CAV@rocky8-victoriacor-com-ar oracle]$ lsblk -f
NAME        FSTYPE      LABEL                     UUID                                   MOUNTPOINT
sda
├─sda1      xfs                                   6d96c2e2-46cd-4748-b7a0-ad73b9f67108   /boot
└─sda2      LVM2_member                           XwPQCw-8QIk-mUju-VBZU-4isu-2ZtC-S2cXoz
  ├─rl-root xfs                                   0674df92-5b11-4e91-87b2-4f2f8b86869c   /
  ├─rl-swap swap                                  bbc78327-9fd9-4121-b3d9-0f53bbb6c724   [SWAP]
  └─rl-home xfs                                   a6ff96f7-e479-4a43-bcac-640688c50e74   /home
sdb
└─sdb1      ext4        Backup - XE               decc33d0-12b2-4537-8e44-e26fd3d8ecc7   /mnt/fra
sdc
├─sdc1      ntfs        Reservado para el sistema 921012A310128E7B
├─sdc2      ntfs                                  08809333809325EA
└─sdc3      ntfs        DatosCav                  941E8CB41E8C90C2


## [CAV@rocky8-victoriacor-com-ar oracle]$ sudo fdisk -l
Disco /dev/sdb: 465,8 GiB, 500106780160 bytes, 976771055 sectores
Unidades: sectores de 1 * 512 = 512 bytes
Tamaño de sector (lógico/físico): 512 bytes / 512 bytes
Tamaño de E/S (mínimo/óptimo): 512 bytes / 512 bytes
Tipo de etiqueta de disco: gpt
Identificador del disco: 345CDAA7-0937-CC4C-897C-415255336F11

Disposit.  Comienzo     Final  Sectores Tamaño Tipo
/dev/sdb1      2048 976771021 976768974 465,8G Sistema de ficheros de Linux


Disco /dev/sda: 223,6 GiB, 240057409536 bytes, 468862128 sectores
Unidades: sectores de 1 * 512 = 512 bytes
Tamaño de sector (lógico/físico): 512 bytes / 512 bytes
Tamaño de E/S (mínimo/óptimo): 512 bytes / 512 bytes
Tipo de etiqueta de disco: dos
Identificador del disco: 0xd2c33873

Disposit.  Inicio Comienzo     Final  Sectores Tamaño Id Tipo
/dev/sda1  *          2048   2099199   2097152     1G 83 Linux
/dev/sda2          2099200 468860927 466761728 222,6G 8e Linux LVM


Disco /dev/sdc: 931,5 GiB, 1000204886016 bytes, 1953525168 sectores
Unidades: sectores de 1 * 512 = 512 bytes
Tamaño de sector (lógico/físico): 512 bytes / 4096 bytes
Tamaño de E/S (mínimo/óptimo): 4096 bytes / 4096 bytes
Tipo de etiqueta de disco: dos
Identificador del disco: 0x08ac249a

Disposit.  Inicio   Comienzo      Final   Sectores Tamaño Id Tipo
/dev/sdc1  *            2048     718847     716800   350M  7 HPFS/NTFS/exFAT
/dev/sdc2             718848 1023999999 1023281152   488G  7 HPFS/NTFS/exFAT
/dev/sdc3         1024000000 1953521663  929521664 443,2G  7 HPFS/NTFS/exFAT


Disco /dev/mapper/rl-root: 70 GiB, 75161927680 bytes, 146800640 sectores
Unidades: sectores de 1 * 512 = 512 bytes
Tamaño de sector (lógico/físico): 512 bytes / 512 bytes
Tamaño de E/S (mínimo/óptimo): 512 bytes / 512 bytes


Disco /dev/mapper/rl-swap: 7,3 GiB, 7876902912 bytes, 15384576 sectores
Unidades: sectores de 1 * 512 = 512 bytes
Tamaño de sector (lógico/físico): 512 bytes / 512 bytes
Tamaño de E/S (mínimo/óptimo): 512 bytes / 512 bytes


Disco /dev/mapper/rl-home: 145,2 GiB, 155940028416 bytes, 304570368 sectores
Unidades: sectores de 1 * 512 = 512 bytes
Tamaño de sector (lógico/físico): 512 bytes / 512 bytes
Tamaño de E/S (mínimo/óptimo): 512 bytes / 512 bytes
[CAV@rocky8-victoriacor-com-ar oracle]$


### [oracle@rocky8-victoriacor-com-ar ~]$ cat /etc/fstab
/dev/mapper/rl-root     /                       xfs     defaults        0 0
UUID=6d96c2e2-46cd-4748-b7a0-ad73b9f67108 /boot                   xfs     defaults        0 0
/dev/mapper/rl-home     /home                   xfs     defaults        0 0
/dev/mapper/rl-swap     none                    swap    defaults        0 0
/dev/sdb1     /mnt/fra                    ext4    defaults        0 0
//192.168.2.83/fra_rocky8 /media/cav2023 cifs credentials=/home/credenciales_cifs,dir_mode=0775,file_mode=0775,uid=54321,gid=54321 0 0
