SELECT CONCAT('# [[', page_title, ']]', if( page_is_redirect, ' (Redirect)', '' ))
  FROM page
  WHERE page_namespace = 0
    AND page_title REGEXP '\\([^)]+_[-—]_'
    AND page_title NOT IN (
      SELECT pl_title 
        FROM pagelinks
        JOIN page as p ON pl_from = p.page_id
        WHERE p.page_namespace=4 
          AND p.page_title = 'Elenchi_generati_offline/Disambiguate_con_trattini_nel_titolo/Whitelist'
    )
  ORDER BY page_title;
