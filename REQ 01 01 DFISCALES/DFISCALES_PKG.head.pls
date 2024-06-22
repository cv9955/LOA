CREATE OR REPLACE PACKAGE dfiscales_pkg AS
    procedure add_cuit(
        p_cuit VARCHAR2,
        p_id out number
    );

    procedure load_from_padron(
        p_cuit VARCHAR2,
        p_id out number
    );

    FUNCTION to_cuit(
        p_cuit VARCHAR2
    )RETURN VARCHAR;

    FUNCTION validar_cuit(
        p_cuit IN VARCHAR2
    )RETURN NUMBER;

    FUNCTION calcular_numero_verificador(
        p_cuit IN VARCHAR2
    )RETURN NUMBER;


END dfiscales_pkg;