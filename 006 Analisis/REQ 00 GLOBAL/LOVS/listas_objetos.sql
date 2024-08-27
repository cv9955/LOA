create or replace TYPE ID_TITLE_TYP AS OBJECT
    ( ID      NUMBER
    , title    VARCHAR2(400)
    );

create or replace TYPE ID_TITLE_VALUE_TYP AS OBJECT
    ( ID      NUMBER
    , title    VARCHAR2(400)
    , value NUMBER
    );

create or replace TYPE KEY_TITLE_TYP AS OBJECT
    ( key      VARCHAR2(20)
    , title    VARCHAR2(400)
    );   

create or replace TYPE TREE_TYP AS OBJECT
    ( ID      Number
    , title   VARCHAR2(400)
    , parent  Number
    );

create or replace TYPE cbte_afip_typ AS OBJECT 
(
    id  INTEGER
   ,title INTEGER
   ,letra CHAR
)

create or replace TYPE list_cbte_afip IS TABLE OF cbte_afip_typ;


create or replace TYPE list_with_value IS TABLE OF ID_TITLE_VALUE_TYP; 

create or replace TYPE list_by_id IS TABLE OF id_title_typ;  

create or replace TYPE list_tree IS TABLE OF TREE_TYP;  

create or replace TYPE list_by_key IS TABLE OF key_title_typ;  


create or replace PACKAGE lista AS
    FUNCTION tablas RETURN list_of_value;
end lista;

create or replace PACKAGE BODY lista AS
     lov_tablas list_of_value;

  function tablas  return list_of_value as
  begin
            return lov_tablas;
  end tablas;

BEGIN

    lov_tablas := list_of_value (
        lista_of_value_typ(1,'CLIENTES'),
        lista_of_value_typ(2,'PROVEEDORES')
        );
        
    lov_status := list_of_value (
        lista_of_value_typ(1,'ACTIVO'),
        lista_of_value_typ(-1,'INACTIVO')       
        );        

    lov_tipos := list_of_value_with_icon (
        lista_of_value_with_icon_typ(1,'NOTA','fa fa-sticky-o'),
        lista_of_value_with_icon_typ(2,'RECODATORIO','fa fa-alarm-clock')
        );


END sticky;