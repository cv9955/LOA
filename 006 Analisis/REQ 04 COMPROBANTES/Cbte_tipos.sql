CREATE TABLE "LOA"."T_CBTE_TIPOS" 
   (	"ID" NUMBER, 
        "TITLE" VARCHAR2(400), 
        "LETRA" CHAR(1), 
        "FLG_COMPRAS" NUMBER, 
        "FLG_VENTAS" NUMBER, 
        "KEY" VARCHAR2(20), 
        "SIGNO" NUMBER(*,0)
   ) ;

/*   

 ID TITLE                                                     L FLG_COMPRAS FLG_VENTAS KEY                       SIGNO
--- --------------------------------------------------------- - ----------- ---------- -------------------- ----------
  1 Factura                                                   A           1            FAC A                         1
  2 Nota de Débito                                            A           1            N/D A                         1
  3 Nota de Crédito                                           A           1            N/C A                        -1
  6 Factura                                                   B           1            FAC B                         1
  7 Nota de Débito                                            B           1            N/D B                         1
  8 Nota de Crédito                                           B           1            N/C B                        -1
  4 Recibos                                                   A                                                       
  5 Notas de Venta al contado                                 A                                                       
  9 Recibos                                                   B                                                       
 10 Notas de Venta al contado                                 B                                                       
 63 Liquidacion                                               A                                                       
 64 Liquidacion                                               B                                                       
 34 Cbtes. A del Anexo I, Apartado A,inc.f,R.G.Nro. 1415      A                                                       
 35 Cbtes. B del Anexo I, Apartado A,inc.f,R.G.Nro. 1415      B                                                       
 39 Otros comprobantes A que cumplan con R.G.Nro. 1415        A                                                       
 40 Otros comprobantes B que cumplan con R.G.Nro. 1415        B                                                       
 60 Cta de Vta y Liquido prod.                                A                                                       
 61 Cta de Vta y Liquido prod.                                B                                                       
 11 Factura                                                   C           1            FAC C                         1
 12 Nota de Débito                                            C           1            N/D C                         1
 13 Nota de Crédito                                           C           1            N/C C                        -1
 15 Recibo                                                    C                                                       
 49 Comprobante de Compra de Bienes Usados a Consumidor       X                                                       
 51 Factura                                                   M           1            FAC M                         1
 52 Nota de Débito                                            M           1            N/D M                         1
 53 Nota de Crédito                                           M           1            N/C M                        -1
 54 Recibo                                                    M                                                       
201 Factura de Crédito electrónica MiPyMEs (FCE)              A           1            FCE A                         1
202 Nota de Débito electrónica MiPyMEs (FCE)                  A           1            NDE A                         1
203 Nota de Crédito electrónica MiPyMEs (FCE)                 A           1            NCE A                        -1
206 Factura de Crédito electrónica MiPyMEs (FCE)              B           1            FCE B                         1
207 Nota de Débito electrónica MiPyMEs (FCE)                  B           1            NDE B                         1
208 Nota de Crédito electrónica MiPyMEs (FCE)                 B           1            NCE B                        -1
211 Factura de Crédito electrónica MiPyMEs (FCE)              C           1            FCE C                         1
212 Nota de Débito electrónica MiPyMEs (FCE)                  C           1            NDE C                         1
213 Nota de Crédito electrónica MiPyMEs (FCE)  


*/