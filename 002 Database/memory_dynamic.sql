SELECT component
,current_size/1024/1024 current_size 
,min_size/1024/1024 min_size 
,max_size/1024/1024 max_size 
,user_specified_size/1024/1024 user_size 
,oper_count,last_oper_type, to_date(last_oper_time,'DD/MM/YY HH24:MI:SS') LAST_OPER_TIME
FROM V$MEMORY_DYNAMIC_COMPONENTS order by current_size desc;

SELECT name, SUM(bytes) FROM V$SGASTAT WHERE pool='large pool' GROUP BY ROLLUP(name);

select * from V$SGASTAT  WHERE pool='large pool';

show parameter SHAR;

CREATE SPFILE FROM MEMORY;

SHOW PARAMETER shared;

SHOW PARAMETER cpu;

ALTER SYSTEM SET shared_servers = 0;

ALTER SYSTEM SET pga_aggregate_limit = 4G;
 
ALTER SESSION SET PARALLEL_DEGREE_POLICY = LIMITED;

alter system set cursor_sharing = FORCE;

SELECT  'total memory for all sessions' title, round(SUM(value)/1024/1204) "M bytes"
  FROM V$SESSTAT, V$STATNAME
 WHERE name = 'session uga memory'
   AND V$SESSTAT.STATISTIC# = V$STATNAME.STATISTIC#
union all
SELECT 'total max mem for all sessions' title , round(SUM(value)/1024/1024) "M bytes" 
  FROM V$SESSTAT, V$STATNAME
 WHERE name = 'session uga memory max'
   AND V$SESSTAT.STATISTIC# = V$STATNAME.STATISTIC#;
   
SELECT SQL_ID, PARSING_SCHEMA_NAME AS SCHEMA, SQL_TEXT, 
    CHILD_NUMBER AS CHILD#, EXECUTIONS AS EXEC FROM V$SQL 
    WHERE SQL_TEXT LIKE '%art%' AND SQL_TEXT NOT LIKE '%SQL_TEXT%' ORDER BY SQL_ID;   
    
select *

from v$sql;    

alter system flush buffer_POOL all;

select * from V$SQLAREA;

SELECT *
  FROM V$SGASTAT
 WHERE name = 'free memory'
   AND pool = 'shared pool';
   
SELECT namespace, pins, pinhits, reloads, invalidations
  FROM V$LIBRARYCACHE
 ORDER BY namespace;   
 
SELECT parameter,
       sum(gets),
       sum(getmisses),
       100*sum(gets - getmisses) / sum(gets) pct_succ_gets,
       sum(modifications) updates
  FROM V$ROWCACHE
 WHERE gets > 0
 GROUP BY parameter; 