# REQ 01 02 : Clientes

## Requisitos
1) lista de vendedores
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



## NOTAS
datos importados desde clientes.csv
## ToDo

## referencias


P108 - SH1:lQDwVb4lNnZphhrVx/6d1Rf4AMs=