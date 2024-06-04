# Control de usuarios
ACL - Access Control List 
### SCHEME TYPES 
> Seleccion de tipo de Esquema de Acceso

- LDAP - ACTIVE DIRECTORY -- Es necesario el servidor LDAP. para empresas mas grandes...
- ORACLE APEX ACCOUNTS  -- Facil de usar, pero no puedo delegar el ALTA de los usuarios... 
- ORACLE DATABASE ACCOUNTS -- 
- SOCIAL SIGN-IN
- OPEN DOOR CREDENTIALS
- **CUSTOM** >> CREO MI PROPIO ACL


## Requisitos
1) lista de usuarios
   > datos a incluir: Nombre, apellido, Email
2) alta de usuario
   > solo Username, contraseña generica para primer acceso 
3) edicion de datos
4) elimnar usuario
5) asignacion de roles
6) login
7) cambio de contraseña
   > desde la barra de tareas
8) opcion para de de alta varios usuarios con el mismo rol
   > wizzard para agilizar la carga masiva


## RQ No Funcional      
1) Acceso solo Administrador   
1) Contraseña Encriptada  
1) Administrador no puede auto eliminarse 


## Capa Datos
### T_USERS [>>](t_users.sql)
### T_USER_ROLES [>>](t_user_roles.sql)
### T_USER_APPLYS [>>](t_user_applys.sql)

## Vistas
### USERS [>>](users.view.sql)


## Applicaction Items
- SESSION_USER_ID
- SESSION_USERNAME
- SESSION_MAIL
- SESSION_FIRST_NAME
- SESSION_LAST_NAME

## Funciones
### ACCESS_CONTROL_PKG [>>](<003 Apex Workspace/access_control_pkg.sql>)
* ADD_USER
* CHANGE_PASSWORD
* VALID_USER
* disable_user
* enable_user
* change_roles

## Diagrama de Paginas
![Diagrama de Paginas](<dfd 00 01 Access Control.png>)



## NOTAS
### asignar privilegios para usar la funcion para encriptar los password
```sql
connect as sysdba
> GRANT EXECUTE ON dbms_crypto TO LOA;

> select *
  from dba_tab_privs
  where table_name = 'DBMS_CRYPTO';
```


## ToDo
### habilitar login en horario limitado
```sql
function check_business_hours return boolean
is
begin
  return to_number(to_char(sysdate, 'hh24')) between 8 and 17;
end check_business_hours;
```

## referencias
https://www.oneoracledeveloper.com/2021/12/managing-users-roles-and-authorization.html
https://www.lrayner.com/post/creating-a-custom-authentication-schema-apex-18-1
https://oracle-base.com/articles/9i/storing-passwords-in-the-database-9i
