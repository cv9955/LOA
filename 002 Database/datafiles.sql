select * from v$tablespace;


select name,blocks * BLOCK_SIZE / 1024 / 1024  as MB 
from v$datafile;

select name, blocks * BLOCK_SIZE / 1024 / 1024  as MB 
from v$tempfile;


