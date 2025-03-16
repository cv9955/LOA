SELECT id
      ,vta_cbte_id
      ,articulo_id
      ,texto
      ,cantidad
      ,precio
      ,cbte_iva_id
      ,neto
      ,iva
      ,iva_valor
      ,iva_title
  FROM vta_items;

SELECT id
      ,vta_remito_id
      ,articulo_id
      ,cantidad
      ,precio
  FROM t_vta_remito_its;

SELECT id
      ,cbtefch
      ,cbtetipo_id
      ,ptovta
      ,docnro
      ,impneto
      ,(
    SELECT SUM(neto)
      FROM vta_items
     WHERE vta_cbte_id=cb.id
) suma_neto
      ,impopex
      ,impiva
      ,(
    SELECT SUM(iva)
      FROM vta_items
     WHERE vta_cbte_id=cb.id
) suma_iva
      ,imptrib
      ,imptotal
      ,cae
      ,(
    SELECT vta_remito_id
      FROM t_vta_applys
     WHERE vta_factura_id=cb.id AND vta_remito_id IS NOT NULL
) vta_remito_id
  FROM t_vta_cbtes cb
 WHERE cbtetipo_id IN(
    SELECT id
      FROM t_cbte_tipos
     WHERE flg_iva=2
)
--order by cbtefch desc
 ORDER BY cbtetipo_id
         ,ptovta DESC
         ,docnro;