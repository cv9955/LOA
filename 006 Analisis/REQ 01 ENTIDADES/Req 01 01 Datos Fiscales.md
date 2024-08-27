# REQ 01 01 : Datos Fiscales


## Caso de Uso 

### Alta de Cliente
Una vez dado de alta el clientes y/o proveedor se agrega la o las cuentas para facturacion
El operador carga el nro de CUIT y presiona BUSCAR
El sistema verifica que el CUIT corresponda con el Nro Verificador. Previamente se eliminan los guinoes si existieran
El sistema busca en la base de datos interna, si existe chequea que no este asignado a otro cliente. en tal caso se genera una mensaje informando el cliente correspondiente.
Si no lo encuentra , comienza la busqueda en el archivo Padron. 
El sistema copia los datos a la Base.
Se asocia al cliente
En caso que no se encuentre en el archivo Padron ... Opcion carga manual. (agrego flag indique existencia en padron) 


### Actualizacion de Archivo Padron. 
Se copia el nuevo archivo en el directorio
to do: rutina de verificacion. 



## Requisitos
1) Listado de Personas Fisicas y Juridicas Imagen del padron de AFIP
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
- [T_DFISCAL](<Datos Fiscales/t_dfiscales.sql>)



## Vistas
### DFISCAL [>>](users.view.sql)


## Applicaction Items

## Funciones
### DFISCALES_PKG [>>](<003 Apex Workspace/access_control_pkg.sql>)
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


## Caso de Uso 

### CU : Asociar Cuit
Descripcion : Busca si el CUIT existe en la tabla, sino lo carga del padron
Actores : EditorEntidades
PreCondicion : Cliente cargado con ID

Flujo Principal
1: Editor Ingresa Nro de CUIT 
2: El sIstema Validar que el CUIT se correcto
3: El sistema Busca en la BD 
4: El sistema devuelve ID y muestra Razon Social del registro
5: Editor Presiona Boton ASOCIAR
6: El sistema Guardar Id de cliente en el registo de DATOS FISCALES

Flujo Secundario : 
2.1: Si el cuit no es valido, el sistema muestra una alerta
3.1: Si el cuit no esta en la BD, Ejecutar CU BuscarEnPadron
3.2: Si el cuit no estan el el Padron, Muestra opcion para agregar manualmente
3.3: Editor Acepta 
3.4: Editor ingresa Razon Social

Post Condicion : El Cuit se asocia al Cliente. Se agrego en cuit a la BD si no existia previamente

### CU : BuscarEnPadron
Descripcion : Buscar en el archivo Padron.txt el nro de Cuit y carga la informacion en la tabla DFISCALES
Actores : Sistema 
PreCondicion : Archivo Padron Vigente, Nro de CUIT valido y no regitrado en la tabla

Flujo Principal
1: Se buscar en la tabla Externa
2: Se Guardan los datos en la tabla DFISCALES
3: Se devuelve ID

Flujo Secundario
2.1 : si no se encuentra se devuelve -1

Post Condicion : Cuit registrado en la tabla DFISCALES


