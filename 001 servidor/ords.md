# ORDS 
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
-- no es necesaria ahora, se seleccion directamente la carpera en /opt/oracle/apex/images durante la instalacion 
[oracle@rocky8 ~]$ cp -r /opt/oracle/apex/images /opt/oracle/ords
```

### crear tablespace
```sql
create tablespace ords
datafile '/opt/oracle/oradata/XE/PDBLOA/ords.dbf'
size 100m autoextend on next 10m maxsize 1g


create temporary tablespace ords_temp
tempfile '/opt/oracle/oradata/XE/PDBLOA/ords_temp.dbf'
size 100m autoextend on next 10m maxsize 1g
```

### install
```
# cd /opt/oracle/ords
# ords --config /opt/oracle/ords install 
```
- [1] Tipo de conexión: Básica
- [2] Conexión básica: HOST=localhost PORT=1521 SERVICE_NAME=pdbloa
       Usuario administrador: SYS AS SYSDBA
- [3] Contraseña de base de datos para usuario de tiempo de ejecución de ORDS (ORDS_PUBLIC_USER): <generar>
- [4] Usuario de tiempo de ejecución de ORDS y tablespaces de esquema:  Valor por defecto: ords Temporal ords_temp
- [5] Función adicional: Acciones de Base de Datos
- [6] Configurar e iniciar ORDS en modo autónomo: Sí
- [7]    Protocolo: HTTP
- [8]       Puerto HTTP: 8080
- [9]   Ubicación de recursos estáticos de APEX: /opt/oracle/apex/images
- [A] Aceptar y continuar - Crear configuración e instalar ORDS en la base de datos
- [Q] Salir - No continuar. Sin cambios


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
