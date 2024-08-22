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
# ords --config /opt/oracle/config install 
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
After=oracle-xe-21c.service

[Service]
User=oracle
WorkingDirectory=/opt/oracle/ords
SyslogIdentifier=ords
#Restart=always
RestartSec=30
TimeoutStartSec=200
TimeoutStopSec=30

# ExecStartPre=/bin/sleep 80   //reemplazado por el After=oracle-xe-21c.service
ExecStart=/opt/oracle/ords/bin/ords --config /opt/oracle/config serve
# ExecStart=/usr/bin/java "-Dorg.eclipse.jetty.server.Request.maxFormContentSize=3000000" -ja$
# standalone

#ExecStart=/root/scripts/start_ords.sh

ExecStop=kill $(ps -ef | grep "ords.war" | grep -v grep| awk '{print $2}')

#ExecStop=/root/scripts/stop_ords.sh

[Install]
WantedBy=multi-user.target
```
> Activo el servicio
```
# systemctl enable --now ords.service

# systemctl status ords.service

# journalctl -u ords.service -f
```


### servicio ORDS -- alternativa NO ACTIVA
[INSTALACION](https://oracle-base.com/articles/misc/oracle-rest-data-services-ords-standalone-mode-22-onward)

> lo intente, se activa el servicio cuando logueo, no al arranque del SO. elimine todo. 
> crear archivo ~/scripts/start_ords.sh
```
#!/bin/bash
export PATH=/usr/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:$PATH
export JAVA_HOME=/usr/java/jdk-17
export ORDS_HOME=/opt/oracle/ords
export ORDS_CONFIG=/opt/config/ords
LOGFILE=/home/oracle/scripts/logs/ords-`date +"%Y""%m""%d"`.log
export _JAVA_OPTIONS="-Xms1126M -Xmx1126M"
nohup ${ORDS_HOME}/bin/ords --config ${ORDS_CONFIG} serve >> $LOGFILE 2>&1 &
echo "View log file with : tail -f $LOGFILE"
```

> archivo ~/scripts/stop_ords.sh
```
#!/bin/bash
export PATH=/usr/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:$PATH
kill `ps -ef | grep [o]rds.war | awk '{print $2}'`
```

> directorio para logs
```
mkdir -p ~/scripts/logs
```

> permisos
```
 chmod u+x ~/scripts/*.sh
```
> configuracion de memoria
export _JAVA_OPTIONS="-Xms1126M -Xmx1126M"

> inicio https
ords --config ${ORDS_CONFIG} serve --secure --port 8443

### configuracion ORDS
```
[oracle@rocky8 cav]$  ${ORDS_HOME}/bin/ords --config ${ORDS_CONFIG} config list
Picked up _JAVA_OPTIONS: -Xms1126M -Xmx1126M

ORDS: versión 24.1 Producción del vie may. 31 18:22:35 2024

Copyright (c) 2010, 2024, Oracle.

Configuración:
  /opt/oracle/config

Pool de bases de datos: default

Valor                                Valor                                  Origen
----------------------------------   ------------------------------------   ----------------
database.api.enabled                 true                                   Global
db.connectionType                    basic                                  Pool
dbrocky8.loagrafica                         localhost                              Pool
db.password                          ******                                 Cartera de pools
db.port                              1521                                   Pool
db.servicename                       pdbloa                                 Pool
db.username                          ORDS_PUBLIC_USER                       Pool
feature.sdw                          true                                   Pool
plsql.gateway.mode                   proxied                                Pool
restEnabledSql.active                true                                   Pool
security.requestValidationFunction   ords_util.authorize_plsql_gateway      Pool
standalone.doc.root                  /opt/oracle/config/global/doc_root     Global
standalone.https.cert                /home/oracle/keystore/ROCKY8.der       Global
standalone.https.cert.key            /home/oracle/keystore/ROCKY8-key.der   Global
standalone.https.port                8443                                   Global
standalone.static.context.path       /i                                     Global
standalone.static.path               /opt/oracle/apex/images                Global
```

### https

> generar claves 
```
mkdir ~/keystore
cd ~/keystore

# Create a self-signed certificate in a JKS keystore.
$JAVA_HOME/bin/keytool -genkey -keyalg RSA -alias rockyloa -keystore keystore.jks \
   -dname "CN=rocky8.loagrafica, OU=Dto Sistema, O=Loa Grafica, L=Caseros, ST=Buenos Aires, C=ARG" \
   -storepass c####### -validity 3600 -keysize 2048 -keypass c#######

# Create a PKCS12 keystore from the JKS keystore.
$JAVA_HOME/bin/keytool -importkeystore -srckeystore keystore.jks -srcalias rockyloa -srcstorepass c####### \
   -destkeystore keystore.p12 -deststoretype PKCS12 -deststorepass c####### -destkeypass c#######    

# Extract the key and certificate in PEM format.
openssl pkcs12 -in keystore.p12 -nodes -nocerts -out rocky8.loagrafica-key.pem
openssl pkcs12 -in keystore.p12 -nokeys -out rocky8.loagrafica.pem

# Convert them to DER format.
openssl pkcs8 -topk8 -inform PEM -outform DER -in rocky8.loagrafica-key.pem -out rocky8.loagrafica-key.der -nocrypt
openssl x509 -inform PEM -outform DER -in rocky8.loagrafica.pem -out rocky8.loagrafica.der   
```

> iniciar ORDS
```
export _JAVA_OPTIONS="-Xms1126M -Xmx1126M"

ords --config ${ORDS_CONFIG} serve --certificate ~/keystore/rocky8.loagrafica.der --key ~/keystore/rocky8.loagrafica-key.der
```
> arranca el servidor en el puerto 8443, pero tira error 400 INVALID SNI


### Cambiar MaxLimit
```
WARNING     *** 
jdbc.MaxLimit en la configuración |ptc|lo| está utilizando un valor de 10. Puede que este valor no se haya ajustado al tamaño correctamente para un entorno de producción ***
jdbc.InitialLimit en la configuración |ptc|lo| está utilizando un valor de 10. Puede que este valor no se haya ajustado al tamaño correctamente para un entorno de producción ***


[oracle@rocky8 ords]$ ords --config /opt/oracle/config config --db-pool loa set jdbc.MaxLimit 50
Picked up _JAVA_OPTIONS: -Xms1126M -Xmx1126M
ORDS: versión 24.1 Producción del mar ago. 20 18:42:00 2024
Copyright (c) 2010, 2024, Oracle.
Configuración:
  /opt/oracle/config
El valor llamado: jdbc.MaxLimit se ha definido en: 50 en la configuración: loa

[oracle@rocky8 ords]$ ords --config /opt/oracle/config config --db-pool loa set jdbc.InitialLimit 50
Picked up _JAVA_OPTIONS: -Xms1126M -Xmx1126M
ORDS: versión 24.1 Producción del mar ago. 20 18:42:17 2024
Copyright (c) 2010, 2024, Oracle.
Configuración:
  /opt/oracle/config
El valor llamado: jdbc.InitialLimit se ha definido en: 50 en la configuración: loa

```
