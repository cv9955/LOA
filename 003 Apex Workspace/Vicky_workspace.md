# Apex WorkSpace
> aqui se documenta la instalacion y configuracion de las aplicaciones APEX
Workspace Name:	VICKY23
Workspace ID:	1250563006841237
Administrators:	
  - CAV - 
  - CESAR -
## Workspace Schemas
- Schemas:	APEX_SCHEMA, VIC
- Tablespaces:	
  - VICKY (32.00 GB total | 0.08 GB used | 0.24 percent used) 
  - APEX24_1 (1.00 GB total | 0.36 GB used | 35.84 percent used)
- Privileges:	
  - create cluster, 
  - create dimension, 
  - create indextype, 
  - create job, 
  - create materialized view, 
  - create operator, 
  - create procedure, 
  - create sequence, 
  - create session, 
  - create synonym, 
  - create table, 
  - create tablespace, 
  - create trigger, 
  - create type, 
  - create view, 
  - execute dynamic mle, 
  - select any dictionary
- Database Role Privileges:	
  - EXP_FULL_DATABASE, 
  - SELECT_CATALOG_ROLE

## Set Workspace Preferences
### Account Login Control
- Account Expiration and Locking: Enable
- Maximum Login Failures Allowed: 10
- End User Account Lifetime (days): 360
### App Builder
- Enable App Builder Yes
### SQL Workshop
- Enable SQL Workshop Yes
- PL/SQL Editing: Allow PL/SQL program unit editing
- Enable RESTful Services No
### Team Development
- Enable Team Development No
### Session Timeout
- Maximum Session Length in Seconds
- Maximum Session Idle Time in Seconds
- Session Timeout Warning in Seconds


## APPS 

### Application 401
- Name              VICKY 2023
- Application Alias VICKY2
- Version release   3.0
- Application Group Unassigned -

## Authentication
- Public User             APEX_PUBLIC_USER
- Authentication Scheme   APEX
  - Scheme Type   Oracle APEX Accounts
  - Session Sharing Type: **Workspace Sharing**

- Configuration Procedure

## Authorization
- Authorization Scheme :  Must Not Be Public User
- Run on Background Job : NO  
- Source for Role or Group Schemes: Access Control User Role Assignments

  - ACCESS CONTROL - GERENCIA
    - Is In Role or Group 
    - Application Role : GERENCIA,gerencia,FIRMA_ARTICULOS
    - Identify error message : Solo Administrativos

  - ACCESS CONTROL - VENDEDOR	
    - Is In Role or Group 
    - Application Role : soy_vendedor
    - Identify error message : Este acceso requiere cuenta de Vendedor

  - ACCESS CONTROL - VICTORIA	
    - Is In Role or Group 
    - Application Role : administracion
    - Identify error message : CONTROL ROL GERENCIA

  - AMIL - EXCLUSIVO						
  - CAV - EXCLUSIVO

## Aplication access control
- Roles
  - 'editar_vendedores'
  - 'CAV'
  - 'COTIZ'
  - 'AMIL'
  - 'FIRMA_ARTICULOS'
  - 'corredor'
  - 'administracion'
  - 'gerencia'
  - 'ver_cuentas_vendedores'
  - 'soy_vendedor'

- User Name - Roles
  - CESAR	  CAV, COTIZ, FIRMA_ARTICULOS, administracion, gerencia, soy_vendedor
  - AMILCAR	AMIL, COTIZ, FIRMA_ARTICULOS, administracion, corredor, gerencia
  - CARLOS	administracion
  - ANDREA	COTIZ, administracion
  - LUCIA	  administracion
  - FER	    corredor, soy_vendedor



## Globalization
- Application Primary Language:       English (United States) (en-us)
- Application Language Derived From:  Application Primary Language
- Document Direction:                 Left-To-Right
- Application Date Format:                DD-MM-YY
- Application Date Time Format:           DD-MM-YY HH24:MI
- Application Timestamp Format:           DD-MM-YY HH:MIPM
- Application Timestamp Time Zone Format: DD-MM-YY HH24:MI
- Character Value Comparison
- Character Value Comparison Behavior:  Database session NLS setting (default)
- Automatic Time Zone :     NO
- Automatic CSV Encoding :  SI



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