# Disco Lleno
> no arranca el servicio oracle 
Service Unavailable
HTTP Status Code: 503
Request ID: 8BatbtxULurB91DfcH12fQ
Request Timestamp: 2025-02-06T14:55:49.638558520Z

El pool de conexiones denominado |loa|lo| ha encontrado un error: el DN del certificado del servidor no coincide: Listener refused the connection with the following error: 
ORA-12514, TNS:listener does not currently know of service requested in connect descriptor (CONNECTION_ID=CekXrOitQAuCWQVHG9ybcQ==)

> verificar disco
[oracle@rocky8 ~]$ df -h
S.ficheros          Tamaño Usados  Disp Uso% Montado en
devtmpfs              5,7G      0  5,7G   0% /dev
tmpfs                 5,7G      0  5,7G   0% /dev/shm
tmpfs                 5,7G    18M  5,7G   1% /run
tmpfs                 5,7G      0  5,7G   0% /sys/fs/cgroup
/dev/mapper/rl-root    70G    70G   20K 100% /
/dev/mapper/rl-home    35G   9,4G   26G  27% /home
/dev/sda1            1014M   465M  550M  46% /boot
tmpfs                 1,2G   4,0K  1,2G   1% /run/user/54321

encuentro esta carpeta 100% llena >> /dev/mapper/rl-root    70G    70G   20K 100% /

cd /opt/oracle
[cav@rocky8 oracle]$ sudo du -h --max-depth=1 | sort -h
0       ./audit
20K     ./config
44K     ./config.old
68K     ./oraInventory
7,6M    ./META-INF
18M     ./dbs
20M     ./cfgtoollogs
121M    ./ords
370M    ./diag
720M    ./homes
1,1G    ./admin
1,1G    ./apex
1,1G    ./apex23
5,9G    ./product
11G     ./oradata
43G     ./fra
64G     .

>> la carpeta fra es muy grande, llena de archivos .dbf , hay que programar el borrado periodico

si no arranca la bd, hay que borrar manualmente y luego reiniciar

[oracle@rocky8 fra]$ find -type f -mtime +30 -exec rm -f {} \;

rman $ 

CONFIGURE ARCHIVELOG DELETION POLICY TO BACKED UP 2 TIMES TO DEVICE TYPE DISK;
delete noprompt archivelog until time 'sysdate-7';
