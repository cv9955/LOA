sqlplus / as sysdba

SQL> startup mount;
Instancia ORACLE iniciada.

Total System Global Area 1610612120 bytes
Fixed Size                  9686424 bytes
Variable Size            1442840576 bytes
Database Buffers          150994944 bytes
Redo Buffers                7090176 bytes
Base de datos montada.
SQL> archivelog list;
SP2-0734: inicio "archivelog..." de comando desconocido - resto de la linea ignorado.

SQL> archive log list;

Modo log de la base de datos              Modo de No Archivado
Archivado automatico             Desactivado
Destino del archivo            /opt/oracle/homes/OraDBHome21cXE/dbs/arch
Secuencia de log en linea mas antigua     151
Secuencia de log actual           153


SQL> show parameter recovery_file_dest

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
db_recovery_file_dest                string
db_recovery_file_dest_size           big integer 0
remote_recovery_file_dest            string


SQL> archive log list;
Modo log de la base de datos              Modo de No Archivado
Archivado automatico             Desactivado
Destino del archivo            /mnt/fra/ARCHIVLOG
Secuencia de log en linea mas antigua     152
Secuencia de log actual           154

SQL> alter system set log_archive_dest_1='LOCATION=/mnt/fra/archivelog/' scope = both;
Sistema modificado.

SQL> shutdown immediate;
Base de datos cerrada.
Base de datos desmontada.
Instancia ORACLE cerrada.

SQL> startup mount;
Instancia ORACLE iniciada.

Total System Global Area 1610612120 bytes
Fixed Size                  9686424 bytes
Variable Size            1090519040 bytes
Database Buffers          503316480 bytes
Redo Buffers                7090176 bytes
Base de datos montada.

SQL> alter database archivelog;
Base de datos modificada.

SQL>  alter database open;
Base de datos modificada.

SQL>  archive log list;
Modo log de la base de datos              Modo de Archivado
Archivado automatico             Activado
Destino del archivo            /mnt/fra/archivelog/
Secuencia de log en linea mas antigua     152
Siguiente secuencia de log para archivar   154
Secuencia de log actual           154

SQL>  alter system switch logfile;
Sistema modificado.

SQL> archive log list;
Modo log de la base de datos              Modo de Archivado
Archivado automatico             Activado
Destino del archivo            /mnt/fra/archivelog/
Secuencia de log en linea mas antigua     153
Siguiente secuencia de log para archivar   154
Secuencia de log actual           155
