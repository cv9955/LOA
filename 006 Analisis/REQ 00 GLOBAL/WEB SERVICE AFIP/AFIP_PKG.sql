create or replace PACKAGE AFIP_PKG AS 

    FUNCTION DUMMY_ri RETURN NUMBER;
    FUNCTION DUMMY_wsfev1 RETURN NUMBER;


    FUNCTION GET_PERSONA (pCUIT VARCHAR2) RETURN NUMBER;


    function FEParamGetActividades return number;

    function get_auth (pService varchar) return clob;

    FUNCTION FECompUltimoAutorizado(pPtoVenta number, pCbteTipo number) return number;
    
    FUNCTION IvaTipo RETURN list_with_value;
    FUNCTION CbteTipo RETURN list_cbte_afip;
    FUNCTION DocTipo RETURN list_by_id;
    FUNCTION TributoTipo RETURN list_by_id;

    procedure FECAESolicitar(pPtoVenta number, pCbteTipo number) ; 

END AFIP_PKG;

/

create or replace PACKAGE BODY AFIP_PKG AS

 lov_ivaTipo list_with_value;
 lov_TributoTipo list_by_id;
 lov_DocTipo list_by_id;
 lov_CbteTipo list_cbte_afip;
 
    
 l_filename varchar2(255);
 l_BLOB BLOB;
 l_CLOB CLOB;
 l_envelope CLOB;
 
 l_response_msg xmltype;
 l_FACTURAS_OK xmltype;
 l_response clob;
 
  l_token_WSFE varchar2(4000);
  l_sign_WSFE varchar2(800);
  l_cuit varchar2(40) := '30676175179';


-- ****** funciones privadas 

FUNCTION fecabreq (P_cbteTipo number, p_ptoVenta number) return varchar  as
    vret varchar2(200);
begin
SELECT  '<ar:FeCabReq><ar:CantReg>'||count( 1)||'</ar:CantReg>'||
            '<ar:PtoVta>'||PtoVta||'</ar:PtoVta>'||
            '<ar:CbteTipo>'||P_cbteTipo||'</ar:CbteTipo></ar:FeCabReq>' into vret
        FROM Facturas_A_solicitar
     WHERE cbteTipo = P_cbteTipo
       and ptovta = p_ptoVenta
       group by ptovta,cbteTipo 
       ;
    return vret;
end fecabreq;


FUNCTION AlicIva (pVTA_FACTURA_ID number) return varchar  as
    vret varchar2(4000);
begin

select listagg(aliciva) into vret from (
    select t.cod_afip,    
        replace(to_char(nvl(sum (CANTIDAD * precio ),0),'FM99999999990D00'),',','.') BaseImp,
        replace(to_char(nvl(sum (CANTIDAD * precio * t.valor /100 ),0),'FM99999999990D00'),',','.') Importe,
            '<ar:AlicIva><ar:Id>'||t.cod_afip||'</ar:Id><ar:BaseImp>'||
        replace(to_char(nvl(sum (CANTIDAD * precio ),0),'FM99999999990D00'),',','.')||
            '</ar:BaseImp><ar:Importe>'||
        replace(to_char(nvl(sum (CANTIDAD * precio * t.valor /100 ),0),'FM99999999990D00'),',','.')||
            '</ar:Importe></ar:AlicIva>' aliciva
          from t_vta_factura_its f  ,t_vta_iva_tipo t 
          where f.iva_tipo_id = t.id
          and f.vta_factura_id = pVTA_FACTURA_ID
            group by t.cod_afip)
;
    return '<ar:Iva>'||vret||'</ar:Iva>';
exception when no_data_found then
    return '';
end AlicIva;




  FUNCTION DUMMY_ri RETURN NUMBER AS
   l_envelope CLOB :=
     '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:a5="http://a5.soap.ws.server.puc.sr/"><soapenv:Header/><soapenv:Body><a5:dummy/></soapenv:Body></soapenv:Envelope>';
  BEGIN
   /* l_response_msg :=  apex_web_service.make_request(
       p_url               => 'https://awshomo.afip.gov.ar/sr-padron/webservices/personaServiceA5',
  --   p_action            => 'https://awshomo.afip.gov.ar/sr-padron/webservices/personaServiceA5/dummy',
       p_envelope          => l_envelope,
       p_wallet_path => 'file:/home/oracle/wallet',
      p_wallet_pwd  => 'AvFB5675' 
     );
     DBMS_OUTPUT.put_line('l_xml=' || l_response_msg.getClobVal());
*/
    RETURN 1;
    
  END DUMMY_ri;


  FUNCTION GET_PERSONA (pCUIT VARCHAR2) RETURN NUMBER AS
  
  BEGIN
  
  SELECT '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:a5="http://a5.soap.ws.server.puc.sr/">
       <soapenv:Header/>
       <soapenv:Body>
          <a5:getPersona_v2>
            <token>'|| TOKEN || '</token>
            <sign>'|| SIGN || '</sign>
             <cuitRepresentada>30676175179</cuitRepresentada>
             <idPersona>'|| pCUIT ||'</idPersona>
          </a5:getPersona_v2>
       </soapenv:Body>
    </soapenv:Envelope>'
    INTO l_envelope
    FROM T_TOKENS
    WHERE service = 'CI'
    AND SYSDATE BETWEEN generationtime AND expiredtime
;
 l_response_msg:= apex_web_service.make_request(
   p_url               => 'https://awshomo.afip.gov.ar/sr-padron/webservices/personaServiceA5',
 --  p_action            => 'https://awshomo.afip.gov.ar/sr-padron/webservices/personaServiceA5',
   p_envelope          => l_envelope,
   p_wallet_path => 'file:/home/oracle/wallet',
   p_wallet_pwd  => 'AvFB5675'
 );
 
      DBMS_OUTPUT.put_line('l_xml=' || l_response_msg.getClobVal());

    return 1;
  END GET_PERSONA;  
    
  FUNCTION FECompUltimoAutorizado(pPtoVenta number, pCbteTipo number) return number AS
    VRET NUMBER;
  BEGIN
  l_envelope:='<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ar="http://ar.gov.afip.dif.FEV1/">'||
              '<soap:Header/><soap:Body><ar:FECompUltimoAutorizado>'||get_auth('wsfe') ||
         '<ar:PtoVta>'|| pPtoVenta ||'</ar:PtoVta><ar:CbteTipo>'|| pCbteTipo ||'</ar:CbteTipo></ar:FECompUltimoAutorizado></soap:Body></soap:Envelope>';

    l_response_msg :=  apex_web_service.make_request(
       p_url               => 'https://wswhomo.afip.gov.ar/wsfev1/service.asmx?op=FECompUltimoAutorizado',
       p_action            => 'http://ar.gov.afip.dif.FEV1/FECompUltimoAutorizado',
       p_envelope          => l_envelope,
       p_wallet_path => 'file:/home/oracle/wallet',
       p_wallet_pwd  => 'AvFB5675' 
     );
     

     
       DBMS_OUTPUT.put_line(l_response_msg.getClobVal());
     VRET := l_response_msg.extract('//CbteNro/text()','xmlns="http://ar.gov.afip.dif.FEV1/"').GETNUMBERVAL();
    
    RETURN VRET;
        

  END FECompUltimoAutorizado;



  FUNCTION DUMMY_wsfev1 RETURN NUMBER AS
   l_envelope CLOB :='
   <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ar="http://ar.gov.afip.dif.FEV1/"><soap:Header/><soap:Body><ar:FEDummy/></soap:Body></soap:Envelope>';
  BEGIN
    l_response_msg :=  apex_web_service.make_request(
       p_url               => 'https://wswhomo.afip.gov.ar/wsfev1/service.asmx?op=FEDummy',
       p_action            => 'http://ar.gov.afip.dif.FEV1/FEDummy',
       p_envelope          => l_envelope,
       p_wallet_path => 'file:/home/oracle/wallet',
       p_wallet_pwd  => 'AvFB5675' 
     );
     
       DBMS_OUTPUT.put_line(l_response_msg.getClobVal());
    RETURN 1;
  END DUMMY_wsfev1;
  
  function FEParamGetActividades return number AS

  BEGIN
   l_envelope:='<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ar="http://ar.gov.afip.dif.FEV1/">' || 
                '<soap:Header/><soap:Body><ar:FEParamGetActividades>' || 
                get_auth('wsfe') || 
                '</ar:FEParamGetActividades></soap:Body></soap:Envelope>';

    l_response_msg :=  apex_web_service.make_request(
       p_url               => 'https://wswhomo.afip.gov.ar/wsfev1/service.asmx?op=FEParamGetActividades',
       p_action            => 'http://ar.gov.afip.dif.FEV1/FEParamGetActividades',
       p_envelope          => l_envelope,
       p_wallet_path => 'file:/home/oracle/wallet',
       p_wallet_pwd  => 'AvFB5675' 
     );
    
       DBMS_OUTPUT.put_line(l_response_msg.getClobVal());
    RETURN 1;
  END FEParamGetActividades;

  function get_auth(pservice varchar) return clob AS
  vret clob;
  
  BEGIN
         SELECT '<ar:Auth><ar:Token>'|| TOKEN || '</ar:Token><ar:Sign>'|| SIGN || '</ar:Sign><ar:Cuit>' || l_cuit || '</ar:Cuit></ar:Auth>'
               into vret
        FROM T_TOKENS
        WHERE lower(service) = pservice
            AND SYSDATE BETWEEN generationtime AND expiredtime
            and rownum = 1
            ;
            
    return vret;  
  END get_auth;
  

procedure FECAESolicitar(pPtoVenta number, pCbteTipo number) as

    cursor cx is
    SELECT * from Facturas_A_solicitar
       where CbteTipo = pCbteTipo
       and PtoVta = pPtoVenta
       ORDER BY nro_cab
       ;
    
    myFactura Facturas_A_solicitar%rowtype;
    l_texto varchar(2000);
    NRO_CAB NUMBER;
    
    R_RESULTADO VARCHAR2(1);
    
begin

    NRO_CAB := FECompUltimoAutorizado(pPtoVenta,pCbteTipo);

-- encabezado con firma
  l_envelope:='<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ar="http://ar.gov.afip.dif.FEV1/">' ||
   '<soap:Header/><soap:Body><ar:FECAESolicitar>';
    DBMS_OUTPUT.put_line(l_envelope);
    
    l_texto:=  get_auth('wsfe');
   dbms_lob.writeAppend( l_envelope, length(l_texto), l_texto ); 
 DBMS_OUTPUT.put_line(l_texto);

-- cantidad de comprobantes , tipo y pto de venta
   l_texto:= '<ar:FeCAEReq>' || fecabreq(P_cbteTipo => 1, p_ptoVenta =>2);
   l_texto:= l_texto || '<ar:FeDetReq>'; -- abro div Detalle 
   dbms_lob.writeAppend( l_envelope, length(l_texto), l_texto ); 
 DBMS_OUTPUT.put_line(l_texto);


    OPEN CX;
    LOOP
    FETCH CX INTO myFactura;
    EXIT WHEN CX%NOTFOUND;
    nro_cab := NRO_CAB +1;
    l_texto := '<ar:FECAEDetRequest>'
            ||'<ar:Concepto>1</ar:Concepto>'
            ||'<ar:DocTipo>80</ar:DocTipo>'
            ||'<ar:DocNro>'||myFactura.cuit||'</ar:DocNro>'
            ||'<ar:CbteDesde>'||nro_cab||'</ar:CbteDesde>'
            ||'<ar:CbteHasta>'||nro_cab||'</ar:CbteHasta>'
            ||'<ar:CbteFch>'||myFactura.cbtefch||'</ar:CbteFch>'
            ||'<ar:ImpTotal>'||myFactura.imptotal||'</ar:ImpTotal>'
            ||'<ar:ImpTotConc>'||0||'</ar:ImpTotConc>'
            ||'<ar:ImpNeto>'||myFactura.impneto||'</ar:ImpNeto>'
            ||'<ar:ImpOpEx>'||myFactura.impopex||'</ar:ImpOpEx>'
            ||'<ar:ImpTrib>'||myFactura.imptrib||'</ar:ImpTrib>'
            ||'<ar:ImpIVA>'||myFactura.impiva||'</ar:ImpIVA>'
            ||'<ar:FchServDesde></ar:FchServDesde>'
            ||'<ar:FchServHasta></ar:FchServHasta>'
            ||'<ar:FchVtoPago></ar:FchVtoPago>'
            ||'<ar:MonId>PES</ar:MonId>'
            ||'<ar:MonCotiz>1</ar:MonCotiz>'; 
 
  DBMS_OUTPUT.put_line(l_texto);
     dbms_lob.writeAppend( l_envelope, length(l_texto), l_texto ); 


  /*   TRIBUTOS             <ar:Tributos>
                     <ar:Tributo>
                        <ar:Id>99</ar:Id>
                        <ar:Desc>ASDASQDJ</ar:Desc>
                        <ar:BaseImp>150</ar:BaseImp>
                        <ar:Alic>5.2</ar:Alic>
                        <ar:Importe>7.8</ar:Importe>
                     </ar:Tributo>
                  </ar:Tributos>

              */


/* IVA */
     l_texto:= AlicIva(myFactura.id);

/* CIERRE FACTURA */ 
     l_texto:= l_texto || '</ar:FECAEDetRequest>';
 DBMS_OUTPUT.put_line(l_texto);
     dbms_lob.writeAppend( l_envelope, length(l_texto), l_texto ); 



    END LOOP;
    CLOSE CX;
 
   l_texto:= '</ar:FeDetReq></ar:FeCAEReq></ar:FECAESolicitar></soap:Body></soap:Envelope>';
 
     DBMS_OUTPUT.put_line(l_texto);
     dbms_lob.writeAppend( l_envelope, length(l_texto), l_texto ); 
     


    l_response_msg :=  apex_web_service.make_request(
       p_url               => 'https://wswhomo.afip.gov.ar/wsfev1/service.asmx?op=FECAESolicitar',
       p_action            => 'http://ar.gov.afip.dif.FEV1/FECAESolicitar',
       p_envelope          => l_envelope,
       p_wallet_path => 'file:/home/oracle/wallet',
       p_wallet_pwd  => 'AvFB5675' 
     );
      
     DBMS_OUTPUT.put_line(l_response_msg.getClobVal());
     
    R_RESULTADO := l_response_msg.extract('//FECAESolicitarResult/FeCabResp/Resultado/text()','xmlns="http://ar.gov.afip.dif.FEV1/"').getStringVal();

    if R_RESULTADO = 'A' then
       DBMS_OUTPUT.PUT_LINE('RESULTADO OK : ' || R_RESULTADO);
       
       SELECT EXTRACT(l_response_msg,'//FECAESolicitarResult/FeDetResp/FECAEDetResponse','xmlns="http://ar.gov.afip.dif.FEV1/"') INTO l_FACTURAS_OK FROM DUAL;
   
   DBMS_OUTPUT.PUT_LINE(l_FACTURAS_OK.getClobVal());
   
      FOR cur_rec IN (
        SELECT xt.*
        FROM  XMLTABLE(XMLNAMESPACES(default 'http://ar.gov.afip.dif.FEV1/'), '/FECAEDetResponse'
                 passing l_FACTURAS_OK
                 COLUMNS 
                   Resultado  VARCHAR2(1)  PATH 'Resultado',
                   Cbte    VARCHAR2(8)  PATH 'CbteDesde',
                   CAE     VARCHAR2(14) PATH 'CAE',
                   CAEFchVto VARCHAR2(8) PATH 'CAEFchVto',
                   Obs  VARCHAR2(4000) path 'Observaciones'
                   
                  ) xt)
      LOOP
        DBMS_OUTPUT.put_line('CBTE=' || cur_rec.Cbte ||  '  CAE=' || cur_rec.CAE );
      END LOOP;
       
     
    else
       DBMS_OUTPUT.PUT_LINE('RESULTADO FAIL: ' || R_RESULTADO);
    end if;

end FECAESolicitar;




  FUNCTION IvaTipo RETURN list_with_value AS
  BEGIN
    RETURN lov_ivatipo;
END IvaTipo;
  

  FUNCTION CbteTipo RETURN list_cbte_afip AS
  BEGIN
    RETURN lov_cbtetipo;
  END CbteTipo;

  FUNCTION DocTipo RETURN list_by_id AS
  BEGIN
    RETURN lov_doctipo;
  END DocTipo;

  FUNCTION TributoTipo RETURN list_by_id AS
  BEGIN
    RETURN lov_tributotipo;
  END TributoTipo;

begin
    lov_ivatipo := list_with_value(
        ID_TITLE_VALUE_TYP(3,'0%',0),
        ID_TITLE_VALUE_TYP(4,'10.5%',.105),
        ID_TITLE_VALUE_TYP(5,'21%',.210),
        ID_TITLE_VALUE_TYP(6,'27%',.270),
        ID_TITLE_VALUE_TYP(8,'5%',.050),
        ID_TITLE_VALUE_TYP(9,'2.5%',.025)
        );

    lov_doctipo := list_by_id(
        id_title_typ(80,'CUIT'),
        ID_TITLE_TYP(86,'CUIL')
        );
        
    lov_tributoTipo := list_by_id(
        id_title_typ(1,'Impuestos nacionales'),
        id_title_typ(2,'Impuestos provinciales'),
        id_title_typ(3,'Impuestos municipales'),
        id_title_typ(4,'Impuestos Internos'),
        id_title_typ(99,'Otro'),
        id_title_typ(5,'IIBB'),
        id_title_typ(6,'Percepción de IVA'),
        id_title_typ(7,'Percepción de IIBB'),
        id_title_typ(8,'Percepciones por Impuestos Municipales'),
        id_title_typ(9,'Otras Percepciones'),
        id_title_typ(13,'Percepción de IVA a no Categorizado')
        );
        
    lov_cbteTipo := list_cbte_afip(
        cbte_afip_typ(1,'Factura','A'),
        cbte_afip_typ(2,'Nota de Débito','A'),
        cbte_afip_typ(3,'Nota de Crédito','A'),
        cbte_afip_typ(6,'Factura','B'),
        cbte_afip_typ(7,'Nota de Débito','B'),
        cbte_afip_typ(8,'Nota de Crédito','B'),
        cbte_afip_typ(4,'Recibos','A'),
        cbte_afip_typ(5,'Notas de Venta al contado','A'),
        cbte_afip_typ(9,'Recibos','B'),
        cbte_afip_typ(10,'Notas de Venta al contado','B'),
        cbte_afip_typ(63,'Liquidacion','A'),
        cbte_afip_typ(64,'Liquidacion','B'),
        cbte_afip_typ(34,'Cbtes. A del Anexo I, Apartado A,inc.f,R.G.Nro. 1415','A'),
        cbte_afip_typ(35,'Cbtes. B del Anexo I, Apartado A,inc.f,R.G.Nro. 1415','B'),
        cbte_afip_typ(39,'Otros comprobantes A que cumplan con R.G.Nro. 1415','A'),
        cbte_afip_typ(40,'Otros comprobantes B que cumplan con R.G.Nro. 1415','B'),
        cbte_afip_typ(60,'Cta de Vta y Liquido prod.','A'),
        cbte_afip_typ(61,'Cta de Vta y Liquido prod.','B'),
        cbte_afip_typ(11,'Factura','C'),
        cbte_afip_typ(12,'Nota de Débito','C'),
        cbte_afip_typ(13,'Nota de Crédito','C'),
        cbte_afip_typ(15,'Recibo','C'),
        cbte_afip_typ(49,'Comprobante de Compra de Bienes Usados a Consumidor Final','X'),
        cbte_afip_typ(51,'Factura','M'),
        cbte_afip_typ(52,'Nota de Débito','M'),
        cbte_afip_typ(53,'Nota de Crédito','M'),
        cbte_afip_typ(54,'Recibo','M'),
        cbte_afip_typ(201,'Factura de Crédito electrónica MiPyMEs (FCE)','A'),
        cbte_afip_typ(202,'Nota de Débito electrónica MiPyMEs (FCE)','A'),
        cbte_afip_typ(203,'Nota de Crédito electrónica MiPyMEs (FCE)','A'),
        cbte_afip_typ(206,'Factura de Crédito electrónica MiPyMEs (FCE)','B'),
        cbte_afip_typ(207,'Nota de Débito electrónica MiPyMEs (FCE)','B'),
        cbte_afip_typ(208,'Nota de Crédito electrónica MiPyMEs (FCE)','B'),
        cbte_afip_typ(211,'Factura de Crédito electrónica MiPyMEs (FCE)','C'),
        cbte_afip_typ(212,'Nota de Débito electrónica MiPyMEs (FCE)','C'),
        cbte_afip_typ(213,'Nota de Crédito electrónica MiPyMEs (FCE)','C')
        );
        
END AFIP_PKG;