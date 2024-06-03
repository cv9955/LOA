estándar 830 IEEE para especificación de requerimiento

# 1 Introducción
El presente documento presentará de forma organizada los requisitos globales

## 1.1	Propósito del documento de requerimiento
El propósito general de este documento es definir la funcionalidad del Modulo Global

## 1.2	Alcance del producto
El modulo contempla acceso de usuarios, listas de valores, 

## 1.3	Definiciones , acrónimos y abreviaturas
|| Definicion|
|-|-|
| IR   | Interactive Report|
| t_   | Tablas de Base de Datos|
| MP   | MENU PRINCIPAL|
| Pn   | PAGINA NRO|
| DLG  | Ventana de Dialogo |
| BTN  | Boton |
| FK   | Foreing Key |

## 1.4	Referencias

 

# 2	Descripción General
# 2.1	Perspectiva del producto

# 2.2	Funciones del producto
- Gestion de usuarios, control de accesso, asignacion de roles, reestablecimiento de passwords
- Gestion de listas de valores genericas. 
  - Monedas: define la moneda de uso comun ($) y otras monedas con registro del tipo de cambio  
  - Unidades: lista las distintas opciones de unidades (unidad, kilos, metros, m2, etc...)
  - Paises, Provincias, Localidades
- Configuracion de Comprobantes (cab_tipo)
- Configuracion de Documentos   (doc_tipo)
- Configuracion de Cuentas (asiento contable)
- Control columna status

# 2.3	Características de los usuarios
- Administradores - Configuracion


# 2.4	Restricciones generales
- 

# 2.5	Suposiciones y dependencias
Este modulo no deberia tener dependencias



# 3	Requerimientos específicos
## RQ00 Modulo Global

### RQ00.1 [USUARIOS](<Req 00 01 Usuarios.md>)
> control de acceso , habilitacion de roles

### RQ00.2 [STATUS](req000.2_status.md)
> centralizo el control de status de todos los objetos

### RQ00.3 [STICKY NOTES](req000.3_stick.md)
> Funcion para tomar notas, comentarios,observaciones Y recordatorios. para visualizar en calendario



# 4	Apéndices

# 5	Índice
