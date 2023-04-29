SELECT CONCAT('* [[', page_title, ']]')
  FROM page
  WHERE page_namespace = 0 AND page_is_redirect = 1
    AND page_title like '%\_o\_%'
    AND page_title NOT IN (SELECT pl_title
      FROM pagelinks JOIN page as p ON pl_from = p.page_id
      WHERE p.page_namespace=4 
        AND p.page_title = 'Elenchi_generati_offline/Voci_e_categorie_con_"o"_nel_titolo/Whitelist_voci')
  ORDER BY page_title;
