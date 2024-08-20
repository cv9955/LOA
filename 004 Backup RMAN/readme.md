https://phoenixnap.com/kb/linux-format-disk

https://www.digitalocean.com/community/tutorials/create-a-partition-in-linux



RMAN> show all;

RMAN configuration parameters for database with db_unique_name XE are:
CONFIGURE RETENTION POLICY TO REDUNDANCY 1; # default
CONFIGURE BACKUP OPTIMIZATION OFF; # default
CONFIGURE DEFAULT DEVICE TYPE TO DISK; # default
CONFIGURE CONTROLFILE AUTOBACKUP ON; # default
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '%F'; # default
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET; # default
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
CONFIGURE MAXSETSIZE TO UNLIMITED; # default
CONFIGURE ENCRYPTION FOR DATABASE OFF; # default
CONFIGURE ENCRYPTION ALGORITHM 'AES128'; # default
CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE ;
CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS; # default
CONFIGURE ARCHIVELOG DELETION POLICY TO NONE; # default
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/opt/oracle/dbs/snapcf_XE.f'; # default


RMAN> backup database include current controlfile;

Starting backup at 20-AUG-24
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=140 device type=DISK

  channel ORA_DISK_1: starting full datafile backup set
    channel ORA_DISK_1: specifying datafile(s) in backup set
    input datafile file number=00024 name=/opt/oracle/oradata/XE/PDBPTC/SYSAUX01.DBF
    input datafile file number=00023 name=/opt/oracle/oradata/XE/PDBPTC/SYSTEM01.DBF
    input datafile file number=00027 name=/opt/oracle/oradata/XE/PDBPTC/APEX23.DBF
    input datafile file number=00031 name=/opt/oracle/oradata/XE/PDBPTC/apex24.dbf
    input datafile file number=00025 name=/opt/oracle/oradata/XE/PDBPTC/UNDOTBS01.DBF
    input datafile file number=00028 name=/opt/oracle/oradata/XE/PDBPTC/PTC.DBF
    input datafile file number=00026 name=/opt/oracle/oradata/XE/PDBPTC/USERS01.DBF
    input datafile file number=00029 name=/opt/oracle/oradata/XE/PDBPTC/PTC_RO.DBF
    channel ORA_DISK_1: starting piece 1 at 20-AUG-24
    channel ORA_DISK_1: finished piece 1 at 20-AUG-24
    piece handle=/opt/oracle/homes/OraDBHome21cXE/dbs/1532ur48_37_1_1 tag=TAG20240820T145816 comment=NONE
  channel ORA_DISK_1: backup set complete, elapsed time: 00:00:15

  channel ORA_DISK_1: starting full datafile backup set
    channel ORA_DISK_1: specifying datafile(s) in backup set
    input datafile file number=00010 name=/opt/oracle/oradata/XE/PDBLOA/sysaux01.dbf
    input datafile file number=00009 name=/opt/oracle/oradata/XE/PDBLOA/system01.dbf
    input datafile file number=00013 name=/opt/oracle/oradata/XE/PDBLOA/apex.dbf
    input datafile file number=00030 name=/opt/oracle/oradata/XE/PDBLOA/apex24.dbf
    input datafile file number=00011 name=/opt/oracle/oradata/XE/PDBLOA/undotbs01.dbf
    input datafile file number=00032 name=/opt/oracle/oradata/XE/PDBLOA/apexflow.dbf
    input datafile file number=00014 name=/opt/oracle/oradata/XE/PDBLOA/ords.dbf
    input datafile file number=00015 name=/opt/oracle/oradata/XE/PDBLOA/loa.DBF
    input datafile file number=00012 name=/opt/oracle/oradata/XE/PDBLOA/users01.dbf
    channel ORA_DISK_1: starting piece 1 at 20-AUG-24
    channel ORA_DISK_1: finished piece 1 at 20-AUG-24
    piece handle=/opt/oracle/homes/OraDBHome21cXE/dbs/1632ur4n_38_1_1 tag=TAG20240820T145816 comment=NONE
  channel ORA_DISK_1: backup set complete, elapsed time: 00:00:15

  channel ORA_DISK_1: starting full datafile backup set
    channel ORA_DISK_1: specifying datafile(s) in backup set
    input datafile file number=00001 name=/opt/oracle/oradata/XE/system01.dbf
    input datafile file number=00003 name=/opt/oracle/oradata/XE/sysaux01.dbf
    input datafile file number=00004 name=/opt/oracle/oradata/XE/undotbs01.dbf
    input datafile file number=00007 name=/opt/oracle/oradata/XE/users01.dbf
    channel ORA_DISK_1: starting piece 1 at 20-AUG-24
    channel ORA_DISK_1: finished piece 1 at 20-AUG-24
    piece handle=/opt/oracle/homes/OraDBHome21cXE/dbs/1732ur56_39_1_1 tag=TAG20240820T145816 comment=NONE
  channel ORA_DISK_1: backup set complete, elapsed time: 00:00:25

  channel ORA_DISK_1: starting full datafile backup set
    channel ORA_DISK_1: specifying datafile(s) in backup set
    input datafile file number=00006 name=/opt/oracle/oradata/XE/pdbseed/sysaux01.dbf
    input datafile file number=00005 name=/opt/oracle/oradata/XE/pdbseed/system01.dbf
    input datafile file number=00008 name=/opt/oracle/oradata/XE/pdbseed/undotbs01.dbf
    channel ORA_DISK_1: starting piece 1 at 20-AUG-24
    channel ORA_DISK_1: finished piece 1 at 20-AUG-24
    piece handle=/opt/oracle/homes/OraDBHome21cXE/dbs/1832ur5v_40_1_1 tag=TAG20240820T145816 comment=NONE
  channel ORA_DISK_1: backup set complete, elapsed time: 00:00:07

  channel ORA_DISK_1: starting full datafile backup set
    channel ORA_DISK_1: specifying datafile(s) in backup set
    including current control file in backup set
    channel ORA_DISK_1: starting piece 1 at 20-AUG-24
    channel ORA_DISK_1: finished piece 1 at 20-AUG-24
    piece handle=/opt/oracle/homes/OraDBHome21cXE/dbs/1932ur67_41_1_1 tag=TAG20240820T145816 comment=NONE
  channel ORA_DISK_1: backup set complete, elapsed time: 00:00:01
Finished backup at 20-AUG-24

Starting Control File and SPFILE Autobackup at 20-AUG-24
  piece handle=/opt/oracle/homes/OraDBHome21cXE/dbs/c-3050888458-20240820-00 comment=NONE
Finished Control File and SPFILE Autobackup at 20-AUG-24




