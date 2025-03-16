/* procedimiento para desactivar TABLESPACE APEX VERSION ANTERIOR */
/* Usuario SYS - PDB */ 

select * from dba_tablespaces;
select * from v$tablespace;
select FILE# ,NAME ,CREATION_TIME ,TS# ,RFILE# ,STATUS ,ENABLED ,ONLINE_TIME ,BYTES /1024/1024 MBYTES,CREATE_BYTES /1024/1024 CREATE_MB,CON_ID from v$datafile;

show pdbs;
alter session set container = pdbloa;
alter session set container = xepdb1;
alter session set container = cdb$root;

/* tablespace APEX a desactivar */
/* Mover los archivos de FLOW_FILES a muevo tablespace */ 
alter tablespace APEX ONLINE;

CREATE TABLESPACE APEX_FLOWS
DATAFILE '/opt/oracle/oradata/XE/PDBLOA/apexflow.dbf'
SIZE 10M AUTOEXTEND ON NEXT 50M MAXSIZE 1G;

alter user FLOWS_FILES quota unlimited on APEX_FLOWS default tablespace APEX_FLOWS;

/* Mover Tabla y Particion LOB */ 
ALTER TABLE FLOWS_FILES.WWV_FLOW_FILE_OBJECTS$ MOVE TABLESPACE APEX_FLOWS;
alter table  FLOWS_FILES.WWV_FLOW_FILE_OBJECTS$ move lob (BLOB_CONTENT) store as (tablespace APEX_FLOWS) ;

/* rebuild Index */ 
select * from all_indexes where status not in ('VALID','N/A');
select 'alter index '||owner||'.'||INDEX_NAME||' rebuild;' from dba_indexes where STATUS='UNUSABLE';

ALTER INDEX FLOWS_FILES.WWV_FLOW_FILES_SESSION_IDX REBUILD TABLESPACE APEX_FLOWS;
ALTER INDEX FLOWS_FILES.WWV_FLOW_FILES_USER_IDX REBUILD TABLESPACE APEX_FLOWS;
ALTER INDEX FLOWS_FILES.WWV_FLOW_FILES_FILE_IDX REBUILD TABLESPACE APEX_FLOWS;
ALTER INDEX FLOWS_FILES.SYS_C008242 REBUILD TABLESPACE APEX_FLOWS;
ALTER INDEX FLOWS_FILES.WWV_FLOW_FILE_OBJ_PK REBUILD TABLESPACE APEX_FLOWS;


/* CONTROLAR QUE QUEDE VACIO */ 
select * from dba_segments where tablespace_name = 'APEX' and owner not in ('APEX_230200');
select * from dba_EXTENTS  where tablespace_name = 'APEX' and owner not in ('APEX_230200');


/* Controlar espacio Libre */    
SELECT TABLESPACE_NAME "TABLESPACE", FILE_ID,
   COUNT(*)    "PIECES",
   MAX(blocks) "MAXIMUM",
   MIN(blocks) "MINIMUM",
   AVG(blocks) "AVERAGE",
   SUM(blocks) "TOTAL",
   round(SUM(BYTES) /1024/1024) "MB libres" 
   FROM DBA_FREE_SPACE
GROUP BY TABLESPACE_NAME, FILE_ID;   


/* Reducir Tablespace SI es necesario */ 
ALTER DATABASE DATAFILE '/opt/oracle/oradata/XE/XEPDB1/apexflow.dbf' RESIZE 10M;

alter tablespace APEX offline;

/* borrar las tablas */ 
BEGIN
FOR c IN (SELECT table_name FROM ALL_TABLES WHERE TABLESPACE_NAME = 'APEX23') LOOP
EXECUTE IMMEDIATE ('DROP TABLE APEX_230100.' || c.table_name || ' CASCADE CONSTRAINTS');
END LOOP;
END;

/* eliminar tablespace y datafiles */
drop tablespace APEX INCLUDING CONTENTS AND DATAFILES ;
