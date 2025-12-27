# Servidor Oracle 21c
archivos en disco USB

## Preinstalador
```
# yum install -y oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm
```

### Password
```
# passwd oracle
```

## Instalacion
```
# yum install oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm

sudo /etc/init.d/oracle-xe-21c configure

export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
export ORACLE_SID=XE
export PATH=$ORACLE_HOME/bin:$PATH

source ~/.bash_profile

sqlplus / as sysdba

SELECT status FROM v$instance;
open
```

