select * from dba_tablespaces;
select * from v$tablespace;

select * from v$datafile;

show pdbs;
alter session set container = xepdb1;
alter session set container = cdb$root;


alter tablespace APEX_1600637334098454 offline;

alter tablespace APEX23 offline;


CREATE TABLESPACE APEX_FLOWS
DATAFILE '/opt/oracle/oradata/XE/XEPDB1/apexflow.dbf'
SIZE 100M AUTOEXTEND ON NEXT 50M MAXSIZE 1G;

ALTER DATABASE DATAFILE '/opt/oracle/oradata/XE/XEPDB1/apexflow.dbf' RESIZE 10M;

ALTER TABLE FLOWS_FILES.WWV_FLOW_FILE_OBJECTS$ MOVE TABLESPACE APEX_FLOWS;

alter user FLOWS_FILES quota unlimited on APEX_FLOWS default tablespace APEX_FLOWS;

select * from all_indexes where status not in ('VALID','N/A');

select 'alter index '||owner||'.'||INDEX_NAME||' rebuild;' from dba_indexes where STATUS='UNUSABLE';

ALTER INDEX FLOWS_FILES.WWV_FLOW_FILES_SESSION_IDX REBUILD TABLESPACE APEX_FLOWS;
ALTER INDEX FLOWS_FILES.WWV_FLOW_FILES_USER_IDX REBUILD TABLESPACE APEX_FLOWS;
ALTER INDEX FLOWS_FILES.WWV_FLOW_FILES_FILE_IDX REBUILD TABLESPACE APEX_FLOWS;
ALTER INDEX FLOWS_FILES.SYS_C0016702 REBUILD TABLESPACE APEX_FLOWS;
ALTER INDEX FLOWS_FILES.WWV_FLOW_FILE_OBJ_PK REBUILD TABLESPACE APEX_FLOWS;


select * from dba_users;

select * from dba_segments
where tablespace_name = 'APEX23'
and owner not in ('APEX_230100')
;

select * from dba_EXTENTS
where tablespace_name = 'APEX23'
and owner not in ('APEX_230100')
;

select * from dba_lobs
WHERE segment_name = 'SYS_LOB0000087735C00017$$';

SELECT table_name, column_name, segment_name 
FROM dba_segments a 
JOIN dba_lobs b USING (owner, segment_name)
WHERE segment_name = 'SYS_LOB0000087735C00017$$';

select 'alter table  '||owner||'.'||table_name||' move lob ('||column_name||') store as (tablespace APEX_FLOWS) ;' 
from dba_lobs
WHERE segment_name = 'SYS_LOB0000087735C00017$$';

alter table  FLOWS_FILES.WWV_FLOW_FILE_OBJECTS$ move lob (BLOB_CONTENT) store as (tablespace APEX_FLOWS) ;

SELECT  FILE_NAME, BLOCKS, TABLESPACE_NAME
   FROM DBA_DATA_FILES;
   
SELECT TABLESPACE_NAME "TABLESPACE", FILE_ID,
   COUNT(*)    "PIECES",
   MAX(blocks) "MAXIMUM",
   MIN(blocks) "MINIMUM",
   AVG(blocks) "AVERAGE",
   SUM(blocks) "TOTAL",
   round(SUM(BYTES) /1024/1024) "MB" 
   FROM DBA_FREE_SPACE
GROUP BY TABLESPACE_NAME, FILE_ID;   

SELECT * FROM DBA_FREE_SPACE;