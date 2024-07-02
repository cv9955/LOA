CREATE OR REPLACE PACKAGE BODY PLAN_CUENTAS_PKG AS
    RAMA_PRINCIPAL_LIST LIST_TREE;
    CUENTA_TIPOS_LIST   LIST_BY_KEY;

    FUNCTION SIGUIENTE_RUBRO_ID(P_PARENT_ID INTEGER)RETURN NUMBER AS
        V_RUBRO_ID NUMBER;
    BEGIN
        SELECT
            MAX(ID)+ 1 INTO V_RUBRO_ID
        FROM
            T_CUENTA_RUBROS
        WHERE
            PARENT = P_PARENT_ID;
        IF V_RUBRO_ID IS NULL THEN
            V_RUBRO_ID := P_PARENT_ID * 10 + 1;
        END IF;

        RETURN V_RUBRO_ID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN(P_PARENT_ID * 10 + 1);
    END SIGUIENTE_RUBRO_ID;

    PROCEDURE AGREGAR_RUBRO(
        P_PARENT_ID INTEGER,
        P_RUBRO_TITLE VARCHAR2,
        P_RUBRO_ID OUT NUMBER
    )AS
    BEGIN
        P_RUBRO_ID := SIGUIENTE_RUBRO_ID(P_PARENT_ID);
        INSERT INTO T_CUENTA_RUBROS(
            ID,
            TITLE,
            PARENT
        )VALUES(
            P_RUBRO_ID,
            P_RUBRO_TITLE,
            P_PARENT_ID
        );
    END AGREGAR_RUBRO;

    PROCEDURE AGREGAR_CUENTA(
        P_CUENTA_RUBRO_ID INTEGER,
        P_TITLE VARCHAR2,
        P_CUENTA_TIPO VARCHAR2,
        P_CUENTA_ID OUT NUMBER,
        P_CUENTA_NUMERO OUT NUMBER
    )AS
    BEGIN
        P_CUENTA_NUMERO := SIGUIENTE_CUENTA_NUM(P_CUENTA_RUBRO_ID);
        INSERT INTO T_CUENTAS (
            CUENTA_RUBRO_ID,
            CUENTA_NUMERO,
            CUENTA_TIPO,
            TITLE
        ) VALUES (
            P_CUENTA_RUBRO_ID,
            P_CUENTA_NUMERO,
            P_CUENTA_TIPO,
            P_TITLE
        ) RETURNING ID INTO P_CUENTA_ID;
    END AGREGAR_CUENTA;

    FUNCTION SIGUIENTE_CUENTA_NUM(
        P_CUENTA_RUBRO_ID INTEGER
    )RETURN NUMBER AS
        V_NEXT_NUM NUMBER;
    BEGIN
        SELECT
            MAX(CUENTA_NUMERO)+ 1 INTO V_NEXT_NUM
        FROM
            T_CUENTAS
        WHERE
            CUENTA_RUBRO_ID = P_CUENTA_RUBRO_ID;
        IF V_NEXT_NUM IS NULL THEN
            V_NEXT_NUM := 1;
        END IF;

        RETURN V_NEXT_NUM;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN(1);
    END SIGUIENTE_CUENTA_NUM;

    FUNCTION CUENTA_TITLE (p_cuenta_id number) return varchar2 as
    vret varchar2 (80) ;
    begin
        select TITLE 
        into vret
        from t_cuentas where id = p_cuenta_id;
        return vret;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'error de cuenta ...';       
        
    end CUENTA_TITLE;

    FUNCTION CUENTA_TO_STRING (p_cuenta_id number) return varchar2 as
    vret varchar2 (80) ;
    begin
        select to_char(cuenta_rubro_id,'000') || to_char(cuenta_numero,'000') || ' - ' || TITLE 
        into vret
        from t_cuentas where id = p_cuenta_id;
        return vret;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'error de cuenta ...';       
        
    end CUENTA_TO_STRING;


    FUNCTION RAMA_PRINCIPAL RETURN LIST_TREE AS
    BEGIN
        RETURN RAMA_PRINCIPAL_LIST;
    END RAMA_PRINCIPAL;

    FUNCTION CUENTA_TIPOS RETURN LIST_BY_KEY AS
    BEGIN
        RETURN CUENTA_TIPOS_LIST;
    END CUENTA_TIPOS;
BEGIN
    RAMA_PRINCIPAL_LIST := LIST_TREE(
        TREE_TYP('1', '  1 - ACTIVO', NULL), 
        TREE_TYP('2', '  2 - PASIVO', NULL), 
        TREE_TYP('3', '  3 - PATRIMONIO NETO', NULL ), 
        TREE_TYP('4', '  4 - GANANCIAS', NULL), 
        TREE_TYP('5', '  5 - GASTOS', NULL), 
        TREE_TYP('11', ' 11 - Activo Corriente', '1'), 
        TREE_TYP('12', ' 12 - Activo No Corriente', '1'), 
        TREE_TYP('21', ' 21 - Pasivo Corriente', '2'), 
        TREE_TYP('22', ' 22 - Pasivo No Corriente', '2'), 
        TREE_TYP('31', ' 31 - Patrimonio Neto', '3'), 
        TREE_TYP('41', ' 41 - Ingresos Ordinarios', '4'), 
        TREE_TYP('42', ' 42 - Ingresos Extraordinarios', '4'), 
        TREE_TYP('51', ' 51 - Gastos Ordinarios', '5'), 
        TREE_TYP('52', ' 52 - Gastos Extraordinarios', '5')
        );

    CUENTA_TIPOS_LIST := LIST_BY_KEY(
        KEY_TITLE_TYP('DEST_CPA', 'CUENTAS DESTINO DE COMPRAS')
        );
END PLAN_CUENTAS_PKG;