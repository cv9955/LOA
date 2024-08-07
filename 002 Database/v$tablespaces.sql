select * from dba_tablespaces;

show pdbs;
alter session set container = xepdb1;
alter session set container = cdb$root;


alter tablespace APEX_1600637334098454 online;



select * from dba_segments
where tablespace_name = 'APEX_1600637334098454'
;

select * from dba_EXTENTS
where tablespace_name = 'APEX_1600637334098454'
;

SELECT  FILE_NAME, BLOCKS, TABLESPACE_NAME
   FROM DBA_DATA_FILES;
   
SELECT TABLESPACE_NAME "TABLESPACE", FILE_ID,
   COUNT(*)    "PIECES",
   MAX(blocks) "MAXIMUM",
   MIN(blocks) "MINIMUM",
   AVG(blocks) "AVERAGE",
   SUM(blocks) "TOTAL",
   SUM(BYTES) /1024 "KB" 
   FROM DBA_FREE_SPACE
GROUP BY TABLESPACE_NAME, FILE_ID;   

SELECT * FROM DBA_FREE_SPACE;