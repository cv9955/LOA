CREATE OR REPLACE PACKAGE BODY DFISCALES_PKG AS
    LOV_ACTIVIDAD_MONOTRIBUTO LIST_BY_KEY;
    LOV_CATEGORIA_IMPUESTOS   LIST_BY_KEY;
    LOV_CATEGORIA_EMPLEADOR   LIST_BY_KEY;
    LOV_CATEGORIA_MONOTRIBUTO LIST_BY_KEY;
    LOV_ESTADO_ACTIVIDAD      LIST_BY_KEY;
    LOV_STATUS                LIST_BY_ID;

    V_CUIT                    VARCHAR(400);
    V_TITLE                   VARCHAR(400);
    V_IMP_GANANCIAS           VARCHAR(2);
    V_IMP_IVA                 VARCHAR(2);
    V_MONOTRIBUTO             VARCHAR(2);
    V_INTEGRANTE_SOC          VARCHAR(1);
    V_EMPLEADOR               VARCHAR(1);
    V_ACT_MONOTRIBUTO         VARCHAR(2);
    CUIT_VALIDO               BOOLEAN:=FALSE;
    LEIDO_DE_PADRON           BOOLEAN:=FALSE;
    V_CLIENTE_ID              INTEGER:=-1;
    V_PROVEDOR_ID             INTEGER:=-1;

    PROCEDURE BUSCAR_CUIT(
        P_CUIT VARCHAR2,
        P_DFISCAL_ID OUT INTEGER,
        P_TITLE OUT VARCHAR2
    )AS
    BEGIN
        IF VALIDAR_CUIT(P_CUIT)<0 THEN
            P_DFISCAL_ID:=-2;
            DBMS_OUTPUT.PUT_LINE('CUIT NO VALIDO :: '
                                 ||P_CUIT);
            RETURN;
        END IF;

        SELECT
            ID,
            TITLE,
            NVL(CLIENTE_ID, -1),
            NVL(PROVEDOR_ID, -1)
       INTO P_DFISCAL_ID,
            P_TITLE,
            V_CLIENTE_ID,
            V_PROVEDOR_ID
        FROM
            T_DFISCALES
        WHERE
            CUIT=V_CUIT;
        DBMS_OUTPUT.PUT_LINE('EXISTE EN T_DFISCALES - id:'||P_DFISCAL_ID);
        DBMS_OUTPUT.PUT_LINE('EXISTE EN T_DFISCALES - CLIENTE id:'||V_CLIENTE_ID);
        DBMS_OUTPUT.PUT_LINE('EXISTE EN T_DFISCALES - PROVEDORE_ID:'||V_PROVEDOR_ID);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            P_DFISCAL_ID :=-1;
            V_CLIENTE_ID :=-1;
            V_PROVEDOR_ID :=-1;
            DBMS_OUTPUT.PUT_LINE('NO EXISTE EN T_DFISCALES');
            LOAD_FROM_PADRON(V_CUIT, P_TITLE);
            IF LEIDO_DE_PADRON THEN
                SAVE_FROM_PADRON(P_DFISCAL_ID);
            ELSE
                DBMS_OUTPUT.PUT_LINE('NO EXISTE EN PADRON');
                P_DFISCAL_ID:=-3;
            END IF;
    END BUSCAR_CUIT;

    PROCEDURE LOAD_FROM_PADRON(
        P_CUIT VARCHAR2,
        P_TITLE OUT VARCHAR2
    )AS
    BEGIN
        V_TITLE :='';
        V_IMP_GANANCIAS :='';
        V_MONOTRIBUTO :='';
        V_IMP_IVA :='';
        V_INTEGRANTE_SOC :='';
        V_EMPLEADOR :='';
        V_ACT_MONOTRIBUTO :='';
        LEIDO_DE_PADRON :=FALSE;
        IF CUIT_VALIDO THEN
            DBMS_OUTPUT.PUT_LINE('BUSCAR EN TABLA EXTERNA: '
                                 ||P_CUIT);
            SELECT
                TITLE,
                IMP_GANANCIAS,
                IMP_IVA,
                MONOTRIBUTO,
                INTEGRANTE_SOC,
                EMPLEADOR,
                ACT_MONOTRIBUTO INTO V_TITLE,
                V_IMP_GANANCIAS,
                V_IMP_IVA,
                V_MONOTRIBUTO,
                V_INTEGRANTE_SOC,
                V_EMPLEADOR,
                V_ACT_MONOTRIBUTO
            FROM
                TE_DFISCALES
            WHERE
                CUIT=V_CUIT;
            DBMS_OUTPUT.PUT_LINE('RAZON SOCIAL : '
                                 ||V_TITLE);
            LEIDO_DE_PADRON :=TRUE;
            P_TITLE :=V_TITLE;
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('NO EXISTE EN padron');
    END LOAD_FROM_PADRON;

    PROCEDURE AGREGAR_CUIT_SIN_PADRON(
        P_CUIT VARCHAR2,
        P_RAZON_SOCIAL VARCHAR2,
        P_DFISCAL_ID OUT NUMBER
    )AS
    BEGIN
        INSERT INTO T_DFISCALES(
            CUIT,
            TITLE,
            STATUS
 --                ,imp_ganancias
 --                ,imp_iva
 --                ,monotributo
 --                ,integrante_soc
 --                ,empleador
 --                ,act_monotributo
        )VALUES(
            P_CUIT,
            P_RAZON_SOCIAL,
            0
 --               ,v_imp_ganancias
 --               ,v_imp_iva
 --               ,v_monotributo
 --               ,v_integrante_soc
 --               ,v_empleador
 --               ,v_act_monotributo
        )RETURNING ID INTO P_DFISCAL_ID;
    END AGREGAR_CUIT_SIN_PADRON;

    PROCEDURE SAVE_FROM_PADRON(
        P_DFISCAL_ID OUT INTEGER
    )AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('save_from_padron');
        IF LEIDO_DE_PADRON THEN
            INSERT INTO T_DFISCALES(
                CUIT,
                TITLE,
                IMP_GANANCIAS,
                IMP_IVA,
                MONOTRIBUTO,
                INTEGRANTE_SOC,
                EMPLEADOR,
                ACT_MONOTRIBUTO,
                STATUS
            )VALUES(
                V_CUIT,
                V_TITLE,
                V_IMP_GANANCIAS,
                V_IMP_IVA,
                V_MONOTRIBUTO,
                V_INTEGRANTE_SOC,
                V_EMPLEADOR,
                V_ACT_MONOTRIBUTO,
                1
            )RETURNING ID INTO P_DFISCAL_ID;
            DBMS_OUTPUT.PUT_LINE('AGREGA REGISTRO : '
                                 ||P_DFISCAL_ID);
            COMMIT;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('OTRO EXCEPTION');
    END SAVE_FROM_PADRON;

    FUNCTION TO_CUIT(
        P_CUIT VARCHAR2
    )RETURN VARCHAR AS
        CUIT VARCHAR(20);
        VRET VARCHAR(200);
    BEGIN
        CUIT :=REPLACE(P_CUIT, '-', '');
        VRET :=SUBSTR(CUIT, 0, 2)
               ||'-'
               ||SUBSTR(CUIT, 3, 8)
                 ||'-'
                 ||SUBSTR(CUIT, -1);
        RETURN VRET;
    END TO_CUIT;

    FUNCTION VALIDAR_CUIT(
        P_CUIT IN VARCHAR2
    )RETURN INTEGER AS
        TYPE V1 IS
            VARRAY(10)OF INTEGER;
        VERIFICADOR INT:=-1; --verificador es un numero entero
        RESULTADO   INT:=0; --resultado es un numero entero
        VRET        INT;
        MULT        V1; --mult es una matriz de 10 numeros
        DIGITO      INT;
    BEGIN
        CUIT_VALIDO :=FALSE;
        V_CUIT :=REPLACE(P_CUIT, '-', '');
        IF LENGTH(V_CUIT)<>11 THEN
            DBMS_OUTPUT.PUT_LINE('cantidad de caracteres incorrectos');
            RETURN-1; --  Si la cantidad de digitos es distinto a 11, la funci�n retorna -1
        END IF;

        VERIFICADOR :=SUBSTR(V_CUIT, -1); --  'verificador es igual al �ltimo d�gito de la CUIT
        RESULTADO :=CALCULAR_NUMERO_VERIFICADOR(V_CUIT);
        IF RESULTADO=VERIFICADOR THEN --        'Si ambas variables coinciden, significa que la CUIT es valida y
            DBMS_OUTPUT.PUT_LINE('CUIT VALIDO');
            CUIT_VALIDO:=TRUE;
            RETURN 1; -- 'retornamos 1
        ELSE
            DBMS_OUTPUT.PUT_LINE('CUIT NO VALIDO');
            RETURN-1; -- 'Si la CUIT no es valida, retornamos 0
        END IF;
    END VALIDAR_CUIT;

    FUNCTION CALCULAR_NUMERO_VERIFICADOR(
        P_CUIT IN VARCHAR2
    )RETURN INTEGER AS
        TYPE V1 IS
            VARRAY(10)OF INTEGER;
        RESULTADO INT:=0; --resultado es un numero entero
        MULT      V1; --mult es una matriz de 10 numeros
        CUIT      VARCHAR(20);
        DIGITO    INT;
    BEGIN
        IF P_CUIT IS NULL THEN
            RETURN-1; -- no hay error
        END IF;

        CUIT :=REPLACE(P_CUIT, '-', '');
        IF LENGTH(CUIT)<10 THEN
            RETURN-2; --  Si la cantidad de digitos es distinto a 11, la funci�n retorna -1
        END IF;

        MULT :=V1(5, 4, 3, 2, 7, 6, 5, 4, 3, 2);
        FOR X IN 1..10 LOOP --'recorremos todos los d�gitos de la CUIT y acumulamos en la variable "resultado"
            DIGITO :=SUBSTR(CUIT, X, 1);
            RESULTADO :=RESULTADO+(MULT(X)*DIGITO);
        END LOOP;

        RESULTADO :=RESULTADO MOD 11; --'obtenemos el resto de dividir "resultado" con 11
        RESULTADO :=11-RESULTADO; --'restamos
        IF RESULTADO=11 THEN --        'si resultado es igual a 11, cambiamos a 0
            RESULTADO:=0;
        ELSIF RESULTADO=10 THEN --        'si resultado es igual a 10, cambiamos a 9
            RESULTADO:=9;
        END IF;

        RETURN RESULTADO;
    END CALCULAR_NUMERO_VERIFICADOR;

    PROCEDURE ASOCIAR_CLIENTE(
        P_CUIT VARCHAR2,
        P_CLIENTE_ID INTEGER,
        P_DFISCAL_ID OUT NUMBER
    )AS
    BEGIN
        BUSCAR_CUIT(P_CUIT, P_DFISCAL_ID, V_TITLE);
        IF V_CLIENTE_ID>0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'ya existe cun cliente con ese cuit');
        END IF;

        IF P_DFISCAL_ID<=0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'no es encontro nro de cuit');
        END IF;
        UPDATE T_DFISCALES
        SET
            CLIENTE_ID=P_CLIENTE_ID
        WHERE
            ID=P_DFISCAL_ID;
    END ASOCIAR_CLIENTE;

    PROCEDURE DESASOCIAR_CLIENTE(
        P_DFISCAL_ID INTEGER
    )AS
    BEGIN
        UPDATE T_DFISCALES
        SET
            CLIENTE_ID=NULL
        WHERE
            ID=P_DFISCAL_ID;
    END DESASOCIAR_CLIENTE;

    PROCEDURE ASOCIAR_PROVEEDOR(
        P_CUIT VARCHAR2,
        P_PROV_ID INTEGER,
        P_DFISCAL_ID OUT NUMBER
    )AS
    BEGIN
        BUSCAR_CUIT(P_CUIT, P_DFISCAL_ID, V_TITLE);
        IF V_PROVEDOR_ID>0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'ya existe cun PROVEEDOR con ese cuit');
        END IF;

        IF P_DFISCAL_ID<=0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'no es encontro nro de cuit');
        END IF;
        UPDATE T_DFISCALES
        SET
            PROVEDOR_ID=P_PROV_ID
        WHERE
            ID=P_DFISCAL_ID;
    END ASOCIAR_PROVEEDOR;

    PROCEDURE DESASOCIAR_PROVEEDOR(
        P_DFISCAL_ID INTEGER
    )AS
    BEGIN
        UPDATE T_DFISCALES
        SET
            PROVEDOR_ID=NULL
        WHERE
            ID=P_DFISCAL_ID;
    END DESASOCIAR_PROVEEDOR;

    FUNCTION CATEGORIA_IMPUESTOS RETURN LIST_BY_KEY AS
    BEGIN
        RETURN LOV_CATEGORIA_IMPUESTOS;
    END CATEGORIA_IMPUESTOS;

    FUNCTION CATEGORIA_MONOTRIBUTO RETURN LIST_BY_KEY AS
    BEGIN
        RETURN LOV_CATEGORIA_MONOTRIBUTO;
    END CATEGORIA_MONOTRIBUTO;

    FUNCTION ACTIVIDAD_MONOTRIBUTO RETURN LIST_BY_KEY AS
    BEGIN
        RETURN LOV_ACTIVIDAD_MONOTRIBUTO;
    END ACTIVIDAD_MONOTRIBUTO;

    FUNCTION CATEGORIA_EMPLEADOR RETURN LIST_BY_KEY AS
    BEGIN
        RETURN LOV_ESTADO_ACTIVIDAD;
    END CATEGORIA_EMPLEADOR;

    FUNCTION CATEGORIA_SOCIEDAD RETURN LIST_BY_KEY AS
    BEGIN
        RETURN LOV_ESTADO_ACTIVIDAD;
    END CATEGORIA_SOCIEDAD;

    FUNCTION STATUS_LIST RETURN LIST_BY_ID AS
    BEGIN
        RETURN LOV_STATUS;
    END STATUS_LIST;
BEGIN
    LOV_CATEGORIA_IMPUESTOS :=LIST_BY_KEY(KEY_TITLE_TYP('NI', 'No Inscripto'), KEY_TITLE_TYP('AC', 'Activo'), KEY_TITLE_TYP('EX', 'Exento' ), KEY_TITLE_TYP('NC', 'No corresponde'));
    LOV_CATEGORIA_MONOTRIBUTO :=LIST_BY_KEY(KEY_TITLE_TYP('NI', 'No Inscripto'), KEY_TITLE_TYP('AC', 'Activo'), KEY_TITLE_TYP('EX', 'Exento' ), KEY_TITLE_TYP('NA', 'No alcanzado'), KEY_TITLE_TYP('XN', 'Exento no alcanzado'), KEY_TITLE_TYP('AN', 'Activo no alcanzado'), KEY_TITLE_TYP ('A ', 'Categoria A'), KEY_TITLE_TYP('B ', 'Categoria B'), KEY_TITLE_TYP('C ', 'Categoria C'), KEY_TITLE_TYP('D ', 'Categoria D'), KEY_TITLE_TYP ('E ', 'Categoria E'), KEY_TITLE_TYP('F ', 'Categoria F'), KEY_TITLE_TYP('G ', 'Categoria G'), KEY_TITLE_TYP('H ', 'Categoria H'), KEY_TITLE_TYP ('I ', 'Categoria I'), KEY_TITLE_TYP('J ', 'Categoria J'), KEY_TITLE_TYP('K ', 'Categoria K'));
    LOV_CATEGORIA_EMPLEADOR :=LIST_BY_KEY(KEY_TITLE_TYP('BT', 'B trabajador promovido'), KEY_TITLE_TYP('AP', 'A actividad primaria'), KEY_TITLE_TYP ('AC', 'A asociado a cooperativa'), KEY_TITLE_TYP('AL', 'A monotributo social locacion'), KEY_TITLE_TYP('AV', 'A monotributo social ventas' ), KEY_TITLE_TYP('AT', 'A trabajador promovido'), KEY_TITLE_TYP('NI', 'No Inscripto'));
    LOV_ACTIVIDAD_MONOTRIBUTO :=LIST_BY_KEY(KEY_TITLE_TYP('00', 'No es monotributista'), KEY_TITLE_TYP('01', 'Comercial'), KEY_TITLE_TYP( '02', 'Profesional'), KEY_TITLE_TYP('03', 'Servicios/Oficio'), KEY_TITLE_TYP('04', 'Industrial'), KEY_TITLE_TYP('05', 'Agropecuaria'), KEY_TITLE_TYP ('06', 'Otros'), KEY_TITLE_TYP('07', 'Eventual'), KEY_TITLE_TYP('08', 'Prest. de Servicio o Locación'), KEY_TITLE_TYP('09', 'Otras actividades' ), KEY_TITLE_TYP('10', 'Ventas'), KEY_TITLE_TYP('10', 'Ventas'), KEY_TITLE_TYP('11', 'Agricultura Familia'));
    LOV_ESTADO_ACTIVIDAD :=LIST_BY_KEY(KEY_TITLE_TYP('N', 'No activo'), KEY_TITLE_TYP('S', 'Activo'));
    LOV_STATUS := LIST_BY_ID(ID_TITLE_TYP(1,'Activo'),ID_TITLE_TYP(0,'No Existe en Archivo Padron'));
END DFISCALES_PKG;