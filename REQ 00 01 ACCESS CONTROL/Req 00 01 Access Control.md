# Control de usuarios

## ACL - Access Control List
SCHEME TYPES 
- LDAP - ACTIVE DIRECTORY -- Es necesario el servidor LDAP. para empresas mas grandes...
- ORACLE APEX ACCOUNTS  -- Facil de usar, pero no puedo delegar el ALTA de los usuarios... 
- ORACLE DATABASE ACCOUNTS -- 
- SOCIAL SIGN-IN
- OPEN DOOR CREDENTIALS
- CUSTOM >> CREO MI PROPIO ACL

## DBMS_CRYPTO
> hay que asignar privilegios para usar la funcion para encriptar los password
```sql
connect as sysdba
> GRANT EXECUTE ON dbms_crypto TO LOA;

> select *
  from dba_tab_privs
  where table_name = 'DBMS_CRYPTO';
```


## Requisitos

| RQ   #1         | LISTA DE USUARIOS 
|-----------------|---------------------
| Introduccion    | 
| Entradas        | 
| Proceso         | 
| Salida          | 
| Acceso          |   
| Manejo de Error | 
| Restricciones   | 
| Roles           | 
| References      | 
| Vinculos        | 

| RQ  #2          | ALTA DE USUARIO 
|-----------------|---------------------
| Introduccion    | 

| RQ #3           | RESTABLECIMIENTO DE CONTRASEÑA 
|-----------------|---------------------
| Introduccion    | 

| RQ00.1.4        | LISTADO DE ROLES 
|-----------------|---------------------
| Introduccion    | 

| RQ00.1.5        | ASIGNACION DE ROLES A USUARIOS 
|-----------------|---------------------
| Introduccion    | 

| RQ #6           | funcion validacion acceso 
|-----------------|---------------------
| Introduccion    | dada un usuario y un rol devuelve TRUE si tiene acceso
| Entradas        | Username , rolname
| Proceso         | funcion
| Salida          | BOOL
| Acceso          | AUTOMATICO  
| Manejo de Error | no existe usuario / no existe rol


## Capa Datos
- [t_users](t_users.sql)
- [t_user_roles](t_user_roles.sql)
- [t_user_applys](t_user_applys.sql)

- [users](users.view.sql)


## Applicaction Items
- SESSION_USER_ID
- SESSION_USERNAME
- SESSION_MAIL
- SESSION_FIRST_NAME
- SESSION_LAST_NAME
- 
## Funciones
[access_control_pkg](<003 Apex Workspace/access_control_pkg.sql>)
. ADD_USER
. CHANGE_PASSWORD
. VALID_USER
. is_required_change_password
. get_password_hash
. disable_user
. enable_user
. change_roles


## referencias
https://www.oneoracledeveloper.com/2021/12/managing-users-roles-and-authorization.html
https://www.lrayner.com/post/creating-a-custom-authentication-schema-apex-18-1
https://oracle-base.com/articles/9i/storing-passwords-in-the-database-9i



## para agregar
> habilitar login en horario limitado
```sql
function check_business_hours return boolean
is
begin
  return to_number(to_char(sysdate, 'hh24')) between 8 and 17;
end check_business_hours;
```

