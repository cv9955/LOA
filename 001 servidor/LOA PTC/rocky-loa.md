[oracle@rocky8 ~]$ cat /etc/fstab


### /etc/fstab
/dev/mapper/rl-root     /                       xfs     defaults        0 0
UUID=e3fe3224-7774-483d-89cc-8a8b8ca7edd7 /boot                   xfs     defaults        0 0
/dev/mapper/rl-home     /home                   xfs     defaults        0 0
/dev/mapper/rl-swap     none                    swap    defaults        0 0


## [cav@rocky8 oracle]$ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda           8:0    0 111,8G  0 disk
├─sda1        8:1    0     1G  0 part /boot
└─sda2        8:2    0 110,8G  0 part
  ├─rl-root 253:0    0    70G  0 lvm  /
  ├─rl-swap 253:1    0   5,9G  0 lvm  [SWAP]
  └─rl-home 253:2    0    35G  0 lvm  /home
sdb           8:16   0 931,5G  0 disk
├─sdb1        8:17   0   100M  0 part
├─sdb2        8:18   0    16M  0 part
├─sdb3        8:19   0 930,9G  0 part
└─sdb4        8:20   0   522M  0 part

## [cav@rocky8 oracle]$ lsblk -f
NAME        FSTYPE      LABEL UUID                                   MOUNTPOINT
sda
├─sda1      xfs               e3fe3224-7774-483d-89cc-8a8b8ca7edd7   /boot
└─sda2      LVM2_member       yjzLVc-3H0X-8GWo-LxrE-0qyD-31tb-0xsboj
  ├─rl-root xfs               6be5fb23-9eba-4088-a314-d9fcbb5c19df   /
  ├─rl-swap swap              c7817713-2b15-4d85-a666-c9db383ee099   [SWAP]
  └─rl-home xfs               1a03d7aa-375d-48a9-a136-024d76e61bf9   /home
sdb
├─sdb1      vfat              92C1-48B0
├─sdb2
├─sdb3      ntfs              5E06C2A406C27C91
└─sdb4      ntfs              84C2955CC29552F2



### [cav@rocky8 oracle]$ sudo fdisk -l
[sudo] password for cav:
## Disco /dev/sda: 111,8 GiB, 120034123776 bytes, 234441648 sectores
Unidades: sectores de 1 * 512 = 512 bytes
Tamaño de sector (lógico/físico): 512 bytes / 512 bytes
Tamaño de E/S (mínimo/óptimo): 512 bytes / 512 bytes
Tipo de etiqueta de disco: dos
Identificador del disco: 0xe5399def

Disposit.  Inicio Comienzo     Final  Sectores Tamaño Id Tipo
/dev/sda1  *          2048   2099199   2097152     1G 83 Linux
/dev/sda2          2099200 234440703 232341504 110,8G 8e Linux LVM


## Disco /dev/sdb: 931,5 GiB, 1000204886016 bytes, 1953525168 sectores
Unidades: sectores de 1 * 512 = 512 bytes
Tamaño de sector (lógico/físico): 512 bytes / 4096 bytes
Tamaño de E/S (mínimo/óptimo): 4096 bytes / 4096 bytes
Tipo de etiqueta de disco: gpt
Identificador del disco: 4CBED485-5838-4A67-9C8D-CEC86FB902F8

Disposit.    Comienzo      Final   Sectores Tamaño Tipo
/dev/sdb1        2048     206847     204800   100M Sistema EFI
/dev/sdb2      206848     239615      32768    16M Reservado para Microsoft
/dev/sdb3      239616 1952451143 1952211528 930,9G Datos básicos de Microsoft
/dev/sdb4  1952452608 1953521663    1069056   522M Entorno de recuperación de Windows


Disco /dev/mapper/rl-root: 70 GiB, 75161927680 bytes, 146800640 sectores
Unidades: sectores de 1 * 512 = 512 bytes
Tamaño de sector (lógico/físico): 512 bytes / 512 bytes
Tamaño de E/S (mínimo/óptimo): 512 bytes / 512 bytes


Disco /dev/mapper/rl-swap: 5,9 GiB, 6287261696 bytes, 12279808 sectores
Unidades: sectores de 1 * 512 = 512 bytes
Tamaño de sector (lógico/físico): 512 bytes / 512 bytes
Tamaño de E/S (mínimo/óptimo): 512 bytes / 512 bytes


Disco /dev/mapper/rl-home: 35 GiB, 37505466368 bytes, 73252864 sectores
Unidades: sectores de 1 * 512 = 512 bytes
Tamaño de sector (lógico/físico): 512 bytes / 512 bytes
Tamaño de E/S (mínimo/óptimo): 512 bytes / 512 bytes
