create or replace PACKAGE BODY dfiscales_pkg AS
        lov_actividad_monotributo list_by_key;
        lov_categoria_impuestos list_by_key;
        lov_categoria_empleador list_by_key;
        lov_categoria_monotributo list_by_key;
        lov_estado_actividad list_by_key;

        v_cuit           VARCHAR(400);
        v_title           VARCHAR(400);
        v_imp_ganancias   VARCHAR(2);
        v_imp_iva         VARCHAR(2);
        v_monotributo     VARCHAR(2);
        v_integrante_soc  VARCHAR(1);
        v_empleador       VARCHAR(1);
        v_act_monotributo VARCHAR(2);
        cuit_valido Boolean := False;
        
  
        leido_de_padron Boolean := False;

v_cliente_id INTEGER := -1;


  procedure buscar_cuit(
        p_cuit VARCHAR2,  -- cuit a buscar
        p_id out INTEGER, -- dfiscal_id encontrado
        p_title out varchar2 -- Razon social encontrada
    ) AS
  BEGIN
        IF validar_cuit(p_cuit) < 0  THEN
            p_id := -2;
            dbms_output.put_line('CUIT NO VALIDO :: ' || p_CUIT );
            RETURN;
        end if;
        
        SELECT  id,title,NVL(cliente_id,-1)
            INTO p_id,p_title,v_cliente_id
            FROM t_dfiscales
            WHERE cuit = v_cuit;
        
         dbms_output.put_line('EXISTE EN T_DFISCALES - id:' || p_id );
         dbms_output.put_line('EXISTE EN T_DFISCALES - CLIENTE id:' || V_CLIENTE_ID );

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
          p_id := -1;  
          v_cliente_id := -1;      
          
         dbms_output.put_line('NO EXISTE EN T_DFISCALES' );
         load_from_padron(v_cuit,p_title);
         if leido_de_padron then 
            save_from_padron(p_id);
         else
         dbms_output.put_line('NO EXISTE EN PADRON');
            P_ID := -3;
        end if;
  END buscar_cuit;

        
        
    procedure load_from_padron(p_cuit VARCHAR2,p_title out varchar2) AS
    begin
        v_title := '';
        v_imp_ganancias := '';
        v_monotributo := '';
        v_imp_iva := '';
        v_integrante_soc := '';
        v_empleador := '';
        v_act_monotributo := '';
        leido_de_padron := False;
        if cuit_valido then 
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
                cuit = v_cuit;
             dbms_output.put_line('RAZON SOCIAL : ' || v_title );
             leido_de_padron := True;
             p_title := v_title;
        end if;           
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
         dbms_output.put_line('NO EXISTE EN padron' );
    end load_from_padron;
    
    procedure AGREGAR_CUIT(p_cuit varchar2,p_razon_social varchar2, p_dfiscal_id out number) AS
  BEGIN
            INSERT INTO t_dfiscales(
                cuit
                ,title
--                ,imp_ganancias
--                ,imp_iva
--                ,monotributo
--                ,integrante_soc
--                ,empleador
--                ,act_monotributo
            )VALUES(
                p_cuit
               ,p_razon_social
--               ,v_imp_ganancias
--               ,v_imp_iva
--               ,v_monotributo
--               ,v_integrante_soc
--               ,v_empleador
--               ,v_act_monotributo
            )RETURNING id INTO p_dfiscal_id;
  END AGREGAR_CUIT;

    
    procedure save_from_padron(p_id out INTEGER) AS
    begin
     dbms_output.put_line('save_from_padron' );
            if leido_de_padron then
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
                v_cuit
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
            end if;
       EXCEPTION
        WHEN OTHERS THEN
        dbms_output.put_line('OTRO EXCEPTION' );
    end save_from_padron;

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
    )RETURN INTEGER AS
        TYPE v1 IS
            VARRAY(10)OF INTEGER;
        verificador INT := -1; --verificador es un numero entero
        resultado   INT := 0; --resultado es un numero entero
        vret        INT;
        mult        v1; --mult es una matriz de 10 numeros
        digito      INT;
    BEGIN
        cuit_valido := False;
        v_cuit := replace(p_cuit,'-','');  
        IF length(v_cuit)<> 11 THEN
        dbms_output.put_line('cantidad de caracteres incorrectos');
            RETURN -1; --  Si la cantidad de digitos es distinto a 11, la funci�n retorna -1
        END IF;
        
        verificador := substr(v_cuit,-1); --  'verificador es igual al �ltimo d�gito de la CUIT
        resultado := calcular_numero_verificador(v_cuit);
        IF resultado = verificador THEN --        'Si ambas variables coinciden, significa que la CUIT es valida y
            dbms_output.put_line('CUIT VALIDO');   
            cuit_valido := True;
            RETURN 1; -- 'retornamos 1
        ELSE
           dbms_output.put_line('CUIT NO VALIDO'); 
            RETURN -1; -- 'Si la CUIT no es valida, retornamos 0
        END IF;
    END validar_cuit;

    FUNCTION calcular_numero_verificador(
        p_cuit IN VARCHAR2
    )RETURN INTEGER AS

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
            RETURN -2; --  Si la cantidad de digitos es distinto a 11, la funci�n retorna -1
        END IF;
        mult := v1(5,4,3,2,7,6,5,4,3,2);

        FOR x IN 1..10 LOOP --'recorremos todos los d�gitos de la CUIT y acumulamos en la variable "resultado"
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

  PROCEDURE ADD_CLIENTE(p_cuit varchar2,p_cliente_id INTEGER) AS
    p_id INTEGER;
  BEGIN
    buscar_cuit(p_cuit,p_id,v_title);
             dbms_output.put_line('cliente :' || v_cliente_id );
    if v_cliente_id > 0 then
         RAISE_APPLICATION_ERROR(-20001,'ya existe cun cliente con ese cuit');
    end if;
    
    if p_id <= 0 then
         RAISE_APPLICATION_ERROR(-20001,'no es encontro nro de cuit');   
    end if;
        update t_dfiscales
        set cliente_id = p_cliente_id
        WHERE ID = p_id;
             dbms_output.put_line('Add clientes Ok');
  END ADD_CLIENTE;


  PROCEDURE DEL_CLIENTE(p_dfiscal_id INTEGER) AS
  BEGIN
        UPDATE T_DFISCALES
        SET CLIENTE_ID = NULL
        WHERE ID = p_dfiscal_id;
END DEL_CLIENTE;

  FUNCTION categoria_impuestos RETURN list_by_key AS
  BEGIN
        RETURN lov_categoria_impuestos;
  END categoria_impuestos;

  FUNCTION categoria_monotributo RETURN list_by_key AS
  BEGIN
    RETURN lov_categoria_monotributo;
  END categoria_monotributo;

  FUNCTION actividad_monotributo RETURN list_by_key AS
  BEGIN
    RETURN lov_actividad_monotributo;
  END actividad_monotributo;

  FUNCTION categoria_empleador RETURN list_by_key AS
  BEGIN
       RETURN lov_estado_actividad;
  END categoria_empleador;

  FUNCTION categoria_sociedad  RETURN list_by_key AS
  BEGIN
    RETURN lov_estado_actividad;
  END categoria_sociedad;

  FUNCTION BUSCAR_CLIENTE(p_dfiscal_id INTEGER,p_cliente_id out number) return boolean AS
  BEGIN
    select cliente_id into p_cliente_id from t_dfiscales where id = p_dfiscal_id;
    return true;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_cliente_id := -1;
          dbms_output.put_line('No existe dfiscal_id');
    RETURN FALSE;
  END BUSCAR_CLIENTE;

begin
        lov_categoria_impuestos := list_by_key (
            key_title_typ('NI','No Inscripto'),
            key_title_typ('AC','Activo'),
            key_title_typ('EX','Exento'),
            key_title_typ('NC','No corresponde')
        );

        lov_categoria_monotributo := list_by_key (
            key_title_typ('NI','No Inscripto'),
            key_title_typ('AC','Activo'),
            key_title_typ('EX','Exento'),
            key_title_typ('NA','No alcanzado'),	
            key_title_typ('XN','Exento no alcanzado'),
            key_title_typ('AN','Activo no alcanzado'),
            key_title_typ('A ','Categoria A'),
            key_title_typ('B ','Categoria B'),
            key_title_typ('C ','Categoria C'),
            key_title_typ('D ','Categoria D'),
            key_title_typ('E ','Categoria E'),
            key_title_typ('F ','Categoria F'),
            key_title_typ('G ','Categoria G'),
            key_title_typ('H ','Categoria H'),
            key_title_typ('I ','Categoria I'),
            key_title_typ('J ','Categoria J'),
            key_title_typ('K ','Categoria K')
           
        );
        
        lov_categoria_empleador := list_by_key (
            key_title_typ('BT','B trabajador promovido'),
            key_title_typ('AP','A actividad primaria'),
            key_title_typ('AC','A asociado a cooperativa'),
            key_title_typ('AL','A monotributo social locacion'),
            key_title_typ('AV','A monotributo social ventas'),
            key_title_typ('AT','A trabajador promovido'),
            key_title_typ('NI','No Inscripto')
        );

        lov_actividad_monotributo := list_by_key (
            key_title_typ('00','No es monotributista'),
            key_title_typ('01','Comercial'),
            key_title_typ('02','Profesional'),
            key_title_typ('03','Servicios/Oficio'),
            key_title_typ('04','Industrial'),
            key_title_typ('05','Agropecuaria'),
            key_title_typ('06','Otros'),
            key_title_typ('07','Eventual'),
            key_title_typ('08','Prest. de Servicio o Locación'),
            key_title_typ('09','Otras actividades'),
            key_title_typ('10','Ventas'),
            key_title_typ('10','Ventas'),
            key_title_typ('11','Agricultura Familia')
        ); 
        lov_estado_actividad := list_by_key (
            key_title_typ('N','No activo'),	
            key_title_typ('S','Activo')	
        ); 
        
END dfiscales_pkg;
/