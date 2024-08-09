# Apex WorkSpace
> aqui se documenta la instalacion y configuracion de las aplicaciones APEX

- WORKSPACE  : LOA2024
- ADMIN USER : CAV

## APPS 

- 100 - PRACTICE
  > ESTA APLICACION LA VOY A UTILIZAR PARA PROBAR COSAS NUEVAS.. 
  > LANGUAJE:  SPANISH - AR

- 103 - BASIC LOGIN
  > Esta aplicacion contiene la pagina de login
  - P9999 - LOGIN PAGE
  - P9998 - CHANGE PASSOWRD PAGE

- 106 - ENTIDADES
  > en esta aplicacion pongo en practica la centalizacion de informacion de empresas y personas.
  > Descarga datos del web services o la tabla externa **te_personas**

  

- 200 - DEVELOP
  > Aqui se hacen los desarrollos de los modulos 
  > Esta aplicacion mantiene informacion de las aplicaciones en desarrollo



- 300 - TESTER
  > Aqui se pone a prueba sin datos reales

- 400 - PRODUCCION
  > Aplicacion Funcional


# Shared Components

## Application Logic
### Application Definition
### Application Items
- SESSION_MAIL
- SESSION_FIRST_NAME
- SESSION_LAST_NAME
- SESSION_USERNAME

### Application Processes
### Application Computations
### Application Settings
### Build Options

## Security
### Security Attributes
  - Application : 100
  - Public User : APEX_PUBLIC_USER
  - Authentication Schemes: **Custom Auth**

### Authentication Schemes
- Oracle APEX Accounts
  - Scheme Type : Oracle APEX Accounts
- *Custom Auth*
  > Esquema personalizado desarrollado por CAV.
  - Scheme Type : Custom
  - Authentication Function Name : **access_control_pkg.valid_user**
  - Session Sharing : **Workspace Sharing**

### Authorization Schemes
- *Administration Rights* 
  -  Scheme Type : PL/SQL Function Returning Boolean

### Application Access Control

### Session State Protection

## Other Components
- Lists of Values
- Plug-ins
- Component Settings
- Shortcuts
- Map Backgrounds
## Navigation and Search
- Lists
- Navigation Menu
- Breadcrumbs
- Navigation Bar List
- Search Configurations
## User Interface
* User Interface Attributes
* Progressive Web App
- Themes
- Templates
- Email Templates
### Files and Reports
- Static Application Files
- Static Workspace Files
- Report Queries
- Report Layouts
## Data Sources
- Data Load Definitions
- REST Enabled SQL
- REST Data Sources
- REST Synchronization
## Workflows and Automations
> investigar
- Task Definitions
- Automations
- Workflows
## Globalization
* Globalization Attributes
- Text Messages
- Application Translations