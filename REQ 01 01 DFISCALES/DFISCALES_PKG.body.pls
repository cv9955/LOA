CREATE OR REPLACE PACKAGE BODY dfiscales_pkg AS

    procedure add_cuit(p_cuit VARCHAR2, p_id out number) AS
        v_cuit           VARCHAR(400);
    BEGIN
        v_cuit := replace(p_cuit,'-','');
        IF validar_cuit(v_cuit)>0  THEN
            SELECT  id
                INTO p_id
                FROM t_dfiscales
                WHERE cuit = v_cuit;
        end if;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
         dbms_output.put_line('NO EXISTE EN T_DFISCALES' );
          load_from_padron(v_cuit,p_id);
    END add_cuit;


    procedure load_from_padron(p_cuit VARCHAR2, p_id out number) AS
        v_title           VARCHAR(400);
        v_imp_ganancias   VARCHAR(2);
        v_imp_iva         VARCHAR(2);
        v_monotributo     VARCHAR(2);
        v_integrante_soc  VARCHAR(1);
        v_empleador       VARCHAR(1);
        v_act_monotributo VARCHAR(2);
    begin
   
         dbms_output.put_line('BUSCAR EN TABLA EXTERNA: ' || p_cuit );
        SELECT
            title
           ,imp_ganancias
           ,imp_iva
           ,monotributo
           ,integrante_soc
           ,empleador
           ,act_monotributo
           into
           v_title
           ,v_imp_ganancias
           ,v_imp_iva
           ,v_monotributo
           ,v_integrante_soc
           ,v_empleador
           ,v_act_monotributo
        FROM
            te_dfiscales
        WHERE
            cuit = p_cuit;

         dbms_output.put_line('RAZON SOCIAL : ' || v_title );
            INSERT INTO t_dfiscales(
                cuit
                ,title
                ,imp_ganancias
                ,imp_iva
                ,monotributo
                ,integrante_soc
                ,empleador
                ,act_monotributo
            )VALUES(
                p_cuit
               ,v_title
               ,v_imp_ganancias
               ,v_imp_iva
               ,v_monotributo
               ,v_integrante_soc
               ,v_empleador
               ,v_act_monotributo
            )RETURNING id INTO p_id;
            
            dbms_output.put_line('AGREGA REGISTRO : ' || p_id );
        COMMIT;
        

        
        
       EXCEPTION
        WHEN NO_DATA_FOUND THEN
         dbms_output.put_line('NO EXISTE EN T_EXTERNA' );
 
        WHEN OTHERS THEN
        dbms_output.put_line('OTRO EXCEPTION' );
 
        
        
   
    end load_from_padron;

    FUNCTION to_cuit(
        p_cuit VARCHAR2
    )RETURN VARCHAR AS
        cuit VARCHAR(20);
        vret VARCHAR(200);
    BEGIN
        cuit := replace(p_cuit,'-','');
        vret := substr(cuit,0,2)
                || '-'
                || substr(cuit,3,8)
                || '-'
                || substr(cuit,-1);

        RETURN vret;
    END to_cuit;

    FUNCTION validar_cuit(
        p_cuit IN VARCHAR2
    )RETURN NUMBER AS

        TYPE v1 IS
            VARRAY(10)OF INTEGER;
        verificador INT := -1; --verificador es un numero entero
        resultado   INT := 0; --resultado es un numero entero
        vret        INT;
        mult        v1; --mult es una matriz de 10 numeros
        digito      INT;
    BEGIN
        IF length(p_cuit)<> 11 THEN
            RETURN -1; --  Si la cantidad de digitos es distinto a 11, la funci?n retorna -1
        END IF;
        verificador := substr(p_cuit,-1); --  'verificador es igual al ?ltimo d?gito de la CUIT

        resultado := calcular_numero_verificador(p_cuit);
        IF resultado = verificador THEN --        'Si ambas variables coinciden, significa que la CUIT es valida y
            dbms_output.put_line('CUIT VALIDO');          
            RETURN 1; -- 'retornamos 1

        ELSE
           dbms_output.put_line('CUIT NO VALIDO'); 
            RETURN -1; -- 'Si la CUIT no es valida, retornamos 0
        END IF;
    END validar_cuit;

    FUNCTION calcular_numero_verificador(
        p_cuit IN VARCHAR2
    )RETURN NUMBER AS

        TYPE v1 IS
            VARRAY(10)OF INTEGER;
        resultado INT := 0; --resultado es un numero entero
        mult      v1; --mult es una matriz de 10 numeros
        cuit      VARCHAR(20);
        digito    INT;
    BEGIN
        IF p_cuit IS NULL THEN
            RETURN -1; -- no hay error
        END IF;
        cuit := replace(p_cuit,'-','');
        IF length(cuit)< 10 THEN
            RETURN -2; --  Si la cantidad de digitos es distinto a 11, la funci?n retorna -1
        END IF;
        mult := v1(5,4,3,2,7,6,5,4,3,2);

        FOR x IN 1..10 LOOP --'recorremos todos los d?gitos de la CUIT y acumulamos en la variable "resultado"
            digito := substr(cuit,x,1);
            resultado := resultado +(mult(x)* digito);
        END LOOP;

        resultado := resultado MOD 11; --'obtenemos el resto de dividir "resultado" con 11
        resultado := 11 - resultado; --'restamos
        IF resultado = 11 THEN --        'si resultado es igual a 11, cambiamos a 0
            resultado := 0;
        ELSIF resultado = 10 THEN --        'si resultado es igual a 10, cambiamos a 9
            resultado := 9;
        END IF;

        RETURN resultado;
    END calcular_numero_verificador;

END dfiscales_pkg;