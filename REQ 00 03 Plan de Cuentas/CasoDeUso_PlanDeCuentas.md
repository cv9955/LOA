Precondicion : 
    Esta Creada la Rama Principal,
    El Usuario tiene permiso EDITOR_PLAN_DE_CUENTAS
Usuario:
    PLAN_DE_CUENTAS_CONFIGURADOR 

1) Flujo Principal Seleccion de Rubro: 
   1) El usuario selecciona Raiz en el arbol plan de cuentas (numeros 1 a 5)
      1) El sistema Oculta Informacion de Rubro y lista de cuentas
      2) El sistema desactiva Botones Agregar Rubro, Editar Rubro, Eliminar Rubro ,Agregar Cuenta
   2) El usuario selecciona Rama en el arbol plan de cuentas (numeros 11 a 99)
      1) El sistema Oculta Informacion de Rubro y lista de cuentas
      2) El sistema habilita Boton Agregar Rubro
      3) El sistema desactiva Botones Editar Rubro, Eliminar Rubro ,Agregar Cuenta
   3) El usuario selecciona Rubro en el arbol plan de cuentas
      1) El sistema muestra Rubro Seleccionado, Configuracion y Lista de cuentas correspondientes
      2) El sistema habilita Botones Agregar Rubro, Editar Rubro, Eliminar Rubro ,Agregar Cuenta  

2) Flujo Principal: Agregar Rubro
   1) El usuario presiona boton Agregar Rubro
   2) el sistema muestra dialogo Agregar Rubro , limpia campos de Titulo y Configuracion
   3) el sistema muestra Rama seleccionada
   4) el sistema muestra Proximo Numero correlativo para la rama seleccionada
   5) el usuario escribe Titulo del Rubro
   6) el usuario selecciona Configuracion, o deja el campo vacio
   7) el usuario preciona Boton Agregar
   8) ejecuta PLAN_DE_CUENTAS_PKG.AGREGAR_RUBRO 
   9) recarga la pagina 

3) Flujo Principal: Editar Rubro
   1) El usuario presiona boton Editar Rubro
   2) el sistema muestra dialogo Editar Rubro
   3) el sistema muestra Titulo y configuracion actual
   5) el usuario modifica Titulo del Rubro y/o Configuracion
   7) el usuario preciona Boton Guadar
   8) ejecuta PLAN_DE_CUENTAS_PKG.EDITAR_RUBRO 
   9) recarga la pagina 

4) Flujo Principal: Eliminar Rubro
   1) El usuario presiona boton Eliminar Rubro
   2) el sistema muestra Alerta Confirmar Eliminacion
   8) ejecuta PLAN_DE_CUENTAS_PKG.ELIMINAR_RUBRO 
   9) recarga la pagina 

5) Flujo Principal: Agregar Cuenta
   1) El usuario presiona boton Agregar Cuenta
   2) el sistema muestra dialogo Agregar Cuenta
   3) el sistema muestra Rubro seleccionada
   4) el sistema muestra Proximo de cuenta Numero correlativo para el rubro seleccionado
   5) el usuario escribe Titulo de la Cuenta
   6) el usuario selecciona Configuracion, o deja el campo vacio
   7) el usuario preciona Boton Agregar
   8) ejecuta PLAN_DE_CUENTAS_PKG.AGREGAR_CUENTA 
   9) recarga la pagina 

6) Flujo Principal: Editar Cuenta
   1) El usuario presiona boton Editar Cuenta
   2) el sistema muestra dialogo Editar Cuenta
   3) el sistema muestra Titulo y configuracion actual
   5) el usuario modifica Titulo del Rubro y/o Configuracion
   6) el usuario preciona Boton Guadar
   7) ejecuta PLAN_DE_CUENTAS_PKG.EDITAR_CUENTA
   8) recarga la pagina 

7) Flujo Principal: Eliminar Cuenta
   1) El usuario presiona boton Eliminar Cuenta
   2) el sistema muestra Alerta Confirmar Eliminacion
   3) ejecuta PLAN_DE_CUENTAS_PKG.ELIMINAR_CUENTA 
   4) recarga la pagina 
