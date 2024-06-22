# REQ 01 04 : Datos Fiscales

## Requisitos
1) lista de empresas
   > datos a incluir: Cuit, Razon Social, Domicilio Fiscal
2) alta de Empresa 
   > Verificar cuit valido, y no repetido => status = 1 
3) bloquear datos
   > una vez verificados => status = 2
4) edicion de datos 
   > solo si no estan verificados, requiere desbloqueo
5) Inhabilitacion de Empresa
   > por que se da de baja el cuit, => status = -1
6) recuperar informacion



## RQ No Funcional      
1) Acceso solo Administrador   
1) Contraseña Encriptada  
1) Administrador no puede auto eliminarse 


## Capa Datos
### T_DFISCAL [>>](t_dfiscal.sql)

## Vistas
### DFISCAL [>>](users.view.sql)


## Applicaction Items

## Funciones
### DATOS_FISCALES_PKG [>>](<003 Apex Workspace/access_control_pkg.sql>)
* ADD_CUIT
* VALID_CUIT
* disable
* enable
* 

## Diagrama de Paginas
![Diagrama de Paginas](<dfd 00 01 Access Control.png>)



## NOTAS

## ToDo

## referencias
