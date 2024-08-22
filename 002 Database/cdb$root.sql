alter session set container = cdb$root;
show pdbs;
show user;

GRANT EXECUTE ON dbms_crypto TO PTC;

SELECT * FROM DBA_USERS;