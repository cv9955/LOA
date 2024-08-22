create or replace PACKAGE dfiscales_pkg AS

    procedure buscar_cuit(
        p_cuit VARCHAR2,
        p_dfiscal_id out INTEGER,
        p_title out varchar2
    );

    procedure load_from_padron(
        p_cuit VARCHAR2,
        p_title out VARCHAR2
    );

    procedure save_from_padron(
        p_dfiscal_id out INTEGER
    );
    
    FUNCTION STATUS_LIST RETURN LIST_BY_ID;


    FUNCTION to_cuit(
        p_cuit VARCHAR2
    )RETURN VARCHAR;

    FUNCTION validar_cuit(
        p_cuit IN VARCHAR2
    )RETURN INTEGER;

    FUNCTION calcular_numero_verificador(
        p_cuit IN VARCHAR2
    )RETURN INTEGER;

    procedure agregar_cuit_sin_padron(p_cuit varchar2,p_razon_social varchar2, p_dfiscal_id out number);
    
    
   
    PROCEDURE ASOCIAR_CLIENTE(p_cuit varchar2,p_cliente_id INTEGER,p_dfiscal_id out number);
    PROCEDURE DESASOCIAR_CLIENTE(p_dfiscal_id INTEGER);    
   
    PROCEDURE ASOCIAR_PROVEEDOR(p_cuit varchar2,p_prov_id INTEGER,p_dfiscal_id out number);
    PROCEDURE DESASOCIAR_PROVEEDOR(p_dfiscal_id INTEGER);    
    
    
    FUNCTION categoria_impuestos RETURN list_by_key;
    FUNCTION categoria_monotributo RETURN list_by_key;
    FUNCTION actividad_monotributo RETURN list_by_key;
    
    FUNCTION categoria_empleador RETURN list_by_key;
    FUNCTION categoria_sociedad  RETURN list_by_key;
 
END dfiscales_pkg;