-- TABLESPACE
CREATE TABLESPACE LOA
DATAFILE '/opt/oracle/oradata/XE/PDBLOA/loa.DBF'
SIZE 10M AUTOEXTEND ON NEXT 10M;

-- crear usuarios
CREATE USER LOA IDENTIFIED BY 40 default tablespace LOA;
grant all privileges to LOA;

CREATE USER CAV IDENTIFIED BY A24 default tablespace LOA;
grant dba to CAV;


select * from dba_users
WHERE ACCOUNT_STATUS = 'OPEN';
